/**
 * `node dev.mjs --api-port=<n>` must point the page at that API server, and its
 * dev page must find /src/boot.mjs (the `spec dev` shell probes for it and
 * 404ed before spectest had one).
 *
 * These start the real dev.mjs on free ports, in dev and in prod mode. Each run
 * records its servers in a temp pid file, and afterEach stops exactly those
 * (a kill of dev.mjs on Windows does not reach its children).
 */
import { describe, it, expect, afterEach } from 'vitest';
import { spawn } from 'node:child_process';
import { createServer } from 'node:net';
import { mkdtempSync, readFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { stopOwnLeftovers, API_PORT_MODULE } from '../../scripts/dev-ports.mjs';

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..', '..');
const DEV_MJS = join(ROOT, 'dev.mjs');

const runs = [];
afterEach(async () => {
  for (const { child, pidFile } of runs.splice(0)) {
    await stopOwnLeftovers(pidFile);
    try { child.kill(); } catch {}
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

/** Start dev.mjs and resolve once it prints its ready banner. */
function startDev(args) {
  const pidFile = join(mkdtempSync(join(tmpdir(), 'spectest-dev-')), 'pids.json');
  const child = spawn(process.execPath, [DEV_MJS, ...args], {
    cwd: ROOT,
    env: { ...process.env, SPECTEST_DEV_PIDFILE: pidFile },
  });
  runs.push({ child, pidFile });
  let out = '';
  return new Promise((resolve, reject) => {
    const onData = (d) => {
      out += d;
      if (out.includes('Press Ctrl+C')) resolve(out);
    };
    child.stdout.on('data', onData);
    child.stderr.on('data', onData);
    child.once('exit', (code) => reject(new Error(`dev.mjs exited ${code}:\n${out}`)));
  });
}

async function get(url, method = 'GET') {
  const res = await fetch(url, { method });
  return { status: res.status, type: res.headers.get('content-type'), body: method === 'HEAD' ? '' : await res.text() };
}

describe('dev.mjs --api-port', () => {
  it('dev mode: the dev page loads /src/boot.mjs and is handed the API port', async () => {
    const [apiPort, port] = [await freePort(), await freePort()];
    await startDev([`--api-port=${apiPort}`, `--port=${port}`]);

    const head = await get(`http://localhost:${port}/src/boot.mjs`, 'HEAD');
    expect(head.status).toBe(200);
    const boot = await get(`http://localhost:${port}/src/boot.mjs`);
    expect(boot.type).toMatch(/javascript/);
    expect(boot.body).toContain('installApiPort');
    expect((await get(`http://localhost:${port}/src/api-origin.mjs`)).status).toBe(200);

    const mod = await get(`http://localhost:${port}/${API_PORT_MODULE}`);
    expect(mod.status).toBe(200);
    expect(mod.body).toContain(`export const API_PORT = ${apiPort};`);

    expect((await get(`http://localhost:${apiPort}/api/tasks`)).status).toBe(200);
  }, 180_000);

  it('prod mode: the page installs the API port before it mounts the app', async () => {
    const [apiPort, port] = [await freePort(), await freePort()];
    await startDev(['--prod', `--api-port=${apiPort}`, `--port=${port}`]);

    const page = await get(`http://localhost:${port}/`);
    expect(page.body).toContain(`installApiPort(${apiPort})`);
    expect(page.body.indexOf('installApiPort(')).toBeLessThan(page.body.indexOf("import('/bundle.js')"));
    const origin = await get(`http://localhost:${port}/src/api-origin.mjs`);
    expect(origin.status).toBe(200);
    expect(origin.type).toMatch(/javascript/);
  }, 180_000);

  it('the port module it writes is gitignored', () => {
    const ignored = readFileSync(join(ROOT, '.gitignore'), 'utf8').split(/\r?\n/);
    expect(ignored).toContain(API_PORT_MODULE);
  });
});
