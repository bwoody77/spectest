/**
 * Port rules for spectest's dev scripts (dev.mjs, scripts/start.js).
 *
 * The one rule: never stop a process this script did not start.
 *
 * These scripts used to "free" their ports by force-killing whatever listened
 * on them, and the API port was 4000, which is Vector's dev slot 0 on a shared
 * machine. So `node dev.mjs` killed a running Vector dev stack. Now:
 *
 *   - The default API port is 4500, clear of every range Vector claims
 *     (dev 4000-4049 / 3300-3349, e2e lanes 4050-4069, test stacks 4100-4149)
 *     and of 4400, which the trade project's observatory bridge uses.
 *   - A busy port is REFUSED: the script names the port and the process that
 *     holds it, leaves that process running, and exits.
 *   - The one exception is a server an earlier dev.mjs run started. dev.mjs
 *     records the pid and port of each server it starts in a pid file, and the
 *     next run stops a recorded pid only while that pid still listens on the
 *     port it was recorded with. A pid that has since been reused by some other
 *     program fails that test and is left alone.
 */

import { execFileSync } from 'node:child_process';
import { createConnection } from 'node:net';
import { readFileSync, writeFileSync, rmSync } from 'node:fs';

export const DEFAULT_API_PORT = 4500;
export const DEFAULT_CLIENT_PORT = 3000;

const isWindows = process.platform === 'win32';

// ---------------------------------------------------------------------------
// Who is listening on a port
// ---------------------------------------------------------------------------

/**
 * Pids listening on TCP `port`, from Windows `netstat -ano` output.
 * A listening row's foreign address is `0.0.0.0:0` or `[::]:0`; that test is
 * used instead of the word LISTENING, which Windows localizes.
 */
export function parseNetstatListeners(text, port) {
  const pids = new Set();
  for (const line of text.split(/\r?\n/)) {
    const cols = line.trim().split(/\s+/);
    if (cols[0] !== 'TCP' || cols.length < 5) continue;
    const [, local, foreign] = cols;
    if (!local.endsWith(`:${port}`)) continue;
    if (foreign !== '0.0.0.0:0' && foreign !== '[::]:0') continue;
    const pid = Number(cols[cols.length - 1]);
    if (Number.isInteger(pid) && pid > 0) pids.add(pid);
  }
  return [...pids];
}

/** Pids from `lsof -t` output (one per line). */
export function parseLsofPids(text) {
  return text.split(/\r?\n/).map((s) => Number(s.trim())).filter((n) => Number.isInteger(n) && n > 0);
}

/** Pids listening on `port` on this machine. Empty when none can be found. */
export function listenerPids(port) {
  try {
    if (isWindows) {
      return parseNetstatListeners(execFileSync('netstat', ['-ano'], { encoding: 'utf8' }), port);
    }
    return parseLsofPids(execFileSync('lsof', ['-t', `-iTCP:${port}`, '-sTCP:LISTEN'], {
      encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'],
    }));
  } catch {
    // lsof exits 1 when nothing matches.
    return [];
  }
}

/**
 * A command line cut down to the program and what it runs, e.g.
 * `node.exe server/index.js` from `"C:\...\node.exe" --flag=… --flag=… server/index.js`.
 * A dev backend's command line can open with 2,000 characters of runtime
 * flags, which would push the script name out of any message.
 */
export function summarizeCommandLine(cmd) {
  const tokens = (cmd.match(/"[^"]*"|\S+/g) ?? []).map((t) => t.replace(/^"|"$/g, ''));
  if (tokens.length === 0) return '';
  const program = tokens[0].split(/[\\/]/).pop();
  const args = tokens.slice(1).filter((t) => !t.startsWith('-')).slice(0, 3);
  return [program, ...args].join(' ');
}

/** One line naming a process, e.g. `node.exe server/index.js`. Best effort. */
export function describePid(pid) {
  try {
    if (isWindows) {
      const cmd = execFileSync('powershell', ['-NoProfile', '-NonInteractive', '-Command',
        `(Get-CimInstance Win32_Process -Filter "ProcessId=${Number(pid)}").CommandLine`,
      ], { encoding: 'utf8', timeout: 8000, stdio: ['ignore', 'pipe', 'ignore'] }).trim();
      if (cmd) return summarizeCommandLine(cmd);
      const row = execFileSync('tasklist', ['/FI', `PID eq ${Number(pid)}`, '/FO', 'CSV', '/NH'], {
        encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'],
      }).trim();
      const image = row.startsWith('"') ? row.split('","')[0].slice(1) : '';
      return image || 'unknown process';
    }
    const cmd = execFileSync('ps', ['-o', 'command=', '-p', String(pid)], {
      encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
    return cmd ? summarizeCommandLine(cmd) : 'unknown process';
  } catch {
    return 'unknown process';
  }
}

/** True when something accepts a connection on localhost:port (IPv4 or IPv6). */
function acceptsConnections(port) {
  const tryHost = (host) => new Promise((resolve) => {
    const sock = createConnection({ port, host });
    sock.setTimeout(1000);
    sock.once('connect', () => { sock.destroy(); resolve(true); });
    sock.once('timeout', () => { sock.destroy(); resolve(false); });
    sock.once('error', () => resolve(false));
  });
  return Promise.all([tryHost('127.0.0.1'), tryHost('::1')]).then(([a, b]) => a || b);
}

/**
 * Check that each port is free. Kills nothing.
 * `ports` is `[{ port, role, override }]`, where `override` tells the user how
 * to pick another port (e.g. `--api-port=<n> or SPECTEST_API_PORT=<n>`).
 * Returns a list of messages, empty when every port is free.
 */
export async function busyPortMessages(ports) {
  const messages = [];
  for (const { port, role, override } of ports) {
    const pids = listenerPids(port);
    if (pids.length === 0 && !(await acceptsConnections(port))) continue;
    const holder = pids.length
      ? pids.map((pid) => `PID ${pid} (${describePid(pid)})`).join(', ')
      : 'a process this script could not identify';
    messages.push([
      `Port ${port} (${role}) is already in use by ${holder}.`,
      `  It was not started by an earlier dev.mjs run, so this script left it running and killed nothing.`,
      `  Stop it yourself, or use another port: ${override}.`,
    ].join('\n'));
  }
  return messages;
}

// ---------------------------------------------------------------------------
// The pid file: what an earlier run started
// ---------------------------------------------------------------------------

export function readPidFile(file) {
  try {
    const data = JSON.parse(readFileSync(file, 'utf8'));
    return data && Array.isArray(data.servers) ? data : null;
  } catch {
    return null;
  }
}

export function writePidFile(file, data) {
  writeFileSync(file, JSON.stringify(data, null, 2) + '\n');
}

/**
 * Remove the pid file, but only if it is still this launcher's: a newer run
 * that stopped this one has already written its own.
 */
export function removePidFile(file, launcherPid = process.pid) {
  const data = readPidFile(file);
  if (!data || data.launcher !== launcherPid) return;
  rmSync(file, { force: true });
}

function killPid(pid) {
  try {
    if (isWindows) {
      // /T: the tree is ours too (e.g. esbuild's service under `spec dev`).
      execFileSync('taskkill', ['/PID', String(pid), '/T', '/F'], { stdio: 'ignore' });
    } else {
      process.kill(pid, 'SIGTERM');
    }
  } catch {}
}

async function waitUntilFree(port, timeoutMs = 5000) {
  const end = Date.now() + timeoutMs;
  while (Date.now() < end) {
    if (listenerPids(port).length === 0) return true;
    await new Promise((r) => setTimeout(r, 200));
  }
  return false;
}

/**
 * Stop the servers an earlier dev.mjs run recorded in `file`, each only while
 * its recorded pid still listens on its recorded port. Removes the file.
 * Returns `{ stopped: [{role, pid, port}], skipped: [{role, pid, port}] }`.
 */
export async function stopOwnLeftovers(file) {
  const data = readPidFile(file);
  const result = { stopped: [], skipped: [] };
  if (!data) return result;
  for (const entry of data.servers) {
    const { pid, port } = entry;
    if (!Number.isInteger(pid) || !Number.isInteger(port) || !listenerPids(port).includes(pid)) {
      result.skipped.push(entry);
      continue;
    }
    killPid(pid);
    await waitUntilFree(port);
    result.stopped.push(entry);
  }
  rmSync(file, { force: true });
  return result;
}

// ---------------------------------------------------------------------------
// Parsing a port setting
// ---------------------------------------------------------------------------

/**
 * Port from `--<flag>=<n>`, else env `envName`, else `fallback`.
 * Throws with a readable message when the value is not a port.
 */
export function resolvePort(args, flag, envName, fallback) {
  const raw = args.find((a) => a.startsWith(`--${flag}=`))?.split('=')[1]
    ?? process.env[envName]
    ?? String(fallback);
  const port = Number(raw);
  if (!Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error(`Not a port: "${raw}" (from --${flag} or ${envName})`);
  }
  return port;
}
