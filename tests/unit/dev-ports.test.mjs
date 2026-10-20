/**
 * dev.mjs must never stop a process it did not start.
 *
 * It used to "free" its ports by force-killing whatever listened on them, and
 * its API port was 4000 — Vector's dev slot 0 — so running it killed a Vector
 * dev stack. These tests hold a port with a SEPARATE process (so a port kill
 * would hit it, not the test runner) and assert it survives.
 */
import { describe, it, expect, afterEach } from 'vitest';
import { spawn } from 'node:child_process';
import { createServer, createConnection } from 'node:net';
import { mkdtempSync, writeFileSync, existsSync, readFileSync, readdirSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  DEFAULT_API_PORT,
  DEFAULT_CLIENT_PORT,
  parseNetstatListeners,
  parseLsofPids,
  summarizeCommandLine,
  stopOwnLeftovers,
} from '../../scripts/dev-ports.mjs';

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..', '..');
const DEV_MJS = join(ROOT, 'dev.mjs');

const children = [];
afterEach(() => {
  for (const c of children.splice(0)) {
    try { c.kill(); } catch {}
  }
});

function freePort() {
  return new Promise((resolve, reject) => {
    const s = createServer();
    s.listen(0, '127.0.0.1', () => {
      const { port } = s.address();
      s.close(() => resolve(port));
    });
    s.on('error', reject);
  });
}

/** A listener in its own process: what a Vector dev backend looks like to dev.mjs. */
async function foreignListener(port) {
  const child = spawn(process.execPath, ['-e',
    `require('net').createServer().listen(${port}, '127.0.0.1', () => console.log('up'))`,
  ], { stdio: ['ignore', 'pipe', 'inherit'] });
  children.push(child);
  await new Promise((resolve, reject) => {
    child.stdout.once('data', resolve);
    child.once('exit', (code) => reject(new Error(`listener exited ${code}`)));
  });
  return child;
}

function isAlive(pid) {
  try { process.kill(pid, 0); return true; } catch { return false; }
}

function canConnect(port) {
  return new Promise((resolve) => {
    const sock = createConnection({ port, host: '127.0.0.1' });
    sock.once('connect', () => { sock.destroy(); resolve(true); });
    sock.once('error', () => resolve(false));
  });
}

function runDev(args, env = {}) {
  return new Promise((resolve) => {
    const child = spawn(process.execPath, [DEV_MJS, ...args], {
      cwd: ROOT,
      env: { ...process.env, ...env },
      stdio: ['ignore', 'pipe', 'pipe'],
    });
    children.push(child);
    let out = '';
    child.stdout.on('data', (d) => { out += d; });
    child.stderr.on('data', (d) => { out += d; });
    const timer = setTimeout(() => { child.kill(); resolve({ code: 'timeout', out }); }, 40_000);
    child.on('exit', (code) => { clearTimeout(timer); resolve({ code, out }); });
  });
}

describe('default ports', () => {
  it('stay clear of every port range Vector claims on a shared machine', () => {
    // Vector: dev backend 4000-4049, dev vite 3300-3349, e2e lanes 4050-4069,
    // test stacks 4100-4149.
    const vector = [[4000, 4049], [3300, 3349], [4050, 4069], [4100, 4149]];
    for (const port of [DEFAULT_API_PORT, DEFAULT_CLIENT_PORT]) {
      for (const [lo, hi] of vector) {
        expect(port < lo || port > hi, `${port} is inside ${lo}-${hi}`).toBe(true);
      }
    }
  });

  it('every hardcoded API URL in the app names the default API port', () => {
    // The app's `source` endpoints are absolute URLs, so the app and dev.mjs
    // must agree on one number. Includes the emitted iOS views and the e2e.
    const files = [];
    const walk = (dir, exts) => {
      if (!existsSync(dir)) return;
      for (const e of readdirSync(dir, { withFileTypes: true })) {
        const p = join(dir, e.name);
        if (e.isDirectory()) walk(p, exts);
        else if (exts.some((x) => e.name.endsWith(x))) files.push(p);
      }
    };
    walk(join(ROOT, 'src'), ['.spec']);
    walk(join(ROOT, 'ios', 'Spectest', 'Views'), ['.swift']);
    walk(join(ROOT, 'tests', 'e2e'), ['.ts']);
    const ports = new Set();
    for (const f of files) {
      for (const m of readFileSync(f, 'utf8').matchAll(/localhost:(\d+)\/api\//g)) ports.add(Number(m[1]));
    }
    expect(ports.size).toBeGreaterThan(0);
    expect([...ports]).toEqual([DEFAULT_API_PORT]);
  });
});

describe('parseNetstatListeners (Windows netstat -ano)', () => {
  const text = [
    'Active Connections',
    '',
    '  Proto  Local Address          Foreign Address        State           PID',
    '  TCP    0.0.0.0:4400           0.0.0.0:0              LISTENING       111',
    '  TCP    127.0.0.1:44001        0.0.0.0:0              LISTENING       222',
    '  TCP    127.0.0.1:4400         127.0.0.1:51234        ESTABLISHED     333',
    '  TCP    [::]:4400              [::]:0                 LISTENING       444',
    '  TCP    [::1]:3000             [::]:0                 LISTENING       555',
    '  UDP    0.0.0.0:4400           *:*                                    666',
    '  TCP    0.0.0.0:4400           0.0.0.0:0              LISTENING       0',
  ].join('\r\n');

  it('finds the pids listening on exactly that port, IPv4 and IPv6', () => {
    expect(parseNetstatListeners(text, 4400).sort()).toEqual([111, 444]);
    expect(parseNetstatListeners(text, 3000)).toEqual([555]);
  });

  it('ignores a longer port with the same prefix, connections, UDP and pid 0', () => {
    expect(parseNetstatListeners(text, 44001)).toEqual([222]);
    expect(parseNetstatListeners(text, 51234)).toEqual([]);
  });
});

describe('summarizeCommandLine', () => {
  it('keeps the program and its script, drops the runtime flags', () => {
    // The shape of a Vector dev backend's command line, flags shortened.
    const vector = '"C:\\Program Files\\nodejs\\node.exe" --use-largepages=off --v8-pool-size=4 '
      + '--tls-cipher-list=TLS_AES_256_GCM_SHA384:HIGH:!aNULL --import=./server/instrument.mjs '
      + '--inspect-port=127.0.0.1:9229 server/index.js';
    expect(summarizeCommandLine(vector)).toBe('node.exe server/index.js');
    expect(summarizeCommandLine('/usr/local/bin/node /Users/b/spectest/server.mjs')).toBe('node /Users/b/spectest/server.mjs');
    expect(summarizeCommandLine('python -m http.server 4500')).toBe('python http.server 4500');
    expect(summarizeCommandLine('')).toBe('');
  });
});

describe('parseLsofPids (macOS/Linux lsof -t)', () => {
  it('reads one pid per line', () => {
    expect(parseLsofPids('123\n456\n\n')).toEqual([123, 456]);
    expect(parseLsofPids('')).toEqual([]);
  });
});

describe('dev.mjs refuses a busy port and kills nothing', () => {
  for (const mode of [[], ['--prod']]) {
    const label = mode.length ? 'dev.mjs --prod' : 'dev.mjs';

    it(`${label}: API port held by another process`, async () => {
      const [apiPort, clientPort] = [await freePort(), await freePort()];
      const holder = await foreignListener(apiPort);
      const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');

      const { code, out } = await runDev([...mode, `--api-port=${apiPort}`, `--port=${clientPort}`],
        { SPECTEST_DEV_PIDFILE: pidFile });

      expect(code).not.toBe(0);
      expect(code).not.toBe('timeout');
      expect(out).toContain(String(apiPort));
      expect(out).toContain(String(holder.pid));
      expect(out).toMatch(/left it running/i);
      expect(out).not.toMatch(/Killing PID/i);
      expect(isAlive(holder.pid)).toBe(true);
      expect(await canConnect(apiPort)).toBe(true);
      // It never got as far as starting its own API server.
      expect(await canConnect(clientPort)).toBe(false);
    }, 60_000);

    it(`${label}: client port held by another process`, async () => {
      const [apiPort, clientPort] = [await freePort(), await freePort()];
      const holder = await foreignListener(clientPort);
      const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');

      const { code, out } = await runDev([...mode, `--api-port=${apiPort}`, `--port=${clientPort}`],
        { SPECTEST_DEV_PIDFILE: pidFile });

      expect(code).not.toBe(0);
      expect(code).not.toBe('timeout');
      expect(out).toContain(String(clientPort));
      expect(out).toMatch(/left it running/i);
      expect(isAlive(holder.pid)).toBe(true);
      expect(await canConnect(clientPort)).toBe(true);
      expect(await canConnect(apiPort)).toBe(false);
    }, 60_000);
  }
});

describe('stopOwnLeftovers: only what an earlier run recorded, and only while it still holds its port', () => {
  function writePids(file, servers) {
    writeFileSync(file, JSON.stringify({ launcher: 999999, mode: 'dev', servers }));
  }

  it('stops a recorded pid that still listens on its recorded port, and clears the file', async () => {
    const port = await freePort();
    const own = await foreignListener(port);
    const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');
    writePids(pidFile, [{ role: 'api', pid: own.pid, port }]);

    const result = await stopOwnLeftovers(pidFile);

    expect(result.stopped.map((s) => s.pid)).toEqual([own.pid]);
    expect(await canConnect(port)).toBe(false);
    expect(existsSync(pidFile)).toBe(false);
  }, 30_000);

  it('leaves a recorded pid alone when it no longer holds the recorded port (pid reuse)', async () => {
    const [heldPort, recordedPort] = [await freePort(), await freePort()];
    const stranger = await foreignListener(heldPort);
    const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');
    writePids(pidFile, [{ role: 'api', pid: stranger.pid, port: recordedPort }]);

    const result = await stopOwnLeftovers(pidFile);

    expect(result.stopped).toEqual([]);
    expect(isAlive(stranger.pid)).toBe(true);
    expect(await canConnect(heldPort)).toBe(true);
  }, 30_000);

  it('leaves whoever now holds a recorded port alone when the recorded pid is gone', async () => {
    const port = await freePort();
    const stranger = await foreignListener(port);
    const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');
    writePids(pidFile, [{ role: 'api', pid: 2147483000, port }]);

    const result = await stopOwnLeftovers(pidFile);

    expect(result.stopped).toEqual([]);
    expect(isAlive(stranger.pid)).toBe(true);
  }, 30_000);

  it('does nothing without a pid file', async () => {
    const result = await stopOwnLeftovers(join(tmpdir(), 'spectest-no-such-pidfile.json'));
    expect(result.stopped).toEqual([]);
  });
});
