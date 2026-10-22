#!/usr/bin/env node
/**
 * Spectest — Startup Script
 *
 * Starts the mock API server and the spec dev server for local development.
 *
 * Steps:
 *  1. Check the API port (4500) and client port (3000) are free. A busy port
 *     is refused, never freed: see scripts/dev-ports.mjs. (This used to kill
 *     whatever held port 4000, which is Vector's dev slot 0.)
 *  2. Ensure spec compiler is built
 *  3. Start the API server (server.mjs)
 *  4. Start the spec dev server (spec dev)
 *
 * Ports: --api-port=<n> / SPECTEST_API_PORT (legacy PORT), and
 * --port=<n> / SPECTEST_PORT (legacy VITE_PORT). The API port reaches the
 * page the way dev.mjs hands it over: see API_PORT_MODULE in dev-ports.mjs.
 */
import { spawn, execSync } from 'child_process';
import net from 'net';
import http from 'http';
import path from 'path';
import { fileURLToPath } from 'url';
import {
  DEFAULT_API_PORT, DEFAULT_CLIENT_PORT, resolvePort, busyPortMessages, API_PORT_MODULE, writeApiPortModule,
} from './dev-ports.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

const ARGS = process.argv.slice(2);
const SERVER_PORT = resolvePort(ARGS, 'api-port', 'SPECTEST_API_PORT', process.env.PORT || DEFAULT_API_PORT);
const CLIENT_PORT = resolvePort(ARGS, 'port', 'SPECTEST_PORT', process.env.VITE_PORT || DEFAULT_CLIENT_PORT);
const SPEC_DIR = process.env.SPEC_DIR || path.resolve(ROOT, '../../spec');

const isWindows = process.platform === 'win32';

// ── Helpers ──────────────────────────────────────────────────────────

function log(msg) {
  console.log(`\x1b[36m[startup]\x1b[0m ${msg}`);
}

function logOk(msg) {
  console.log(`\x1b[32m  ✓\x1b[0m ${msg}`);
}

function logWarn(msg) {
  console.log(`\x1b[33m  !\x1b[0m ${msg}`);
}

function logErr(msg) {
  console.error(`\x1b[31m  ✗\x1b[0m ${msg}`);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function tcpConnect(host, port, timeout = 3000) {
  return new Promise(resolve => {
    const socket = new net.Socket();
    let done = false;
    const finish = (result) => {
      if (!done) { done = true; socket.destroy(); resolve(result); }
    };
    socket.setTimeout(timeout);
    socket.on('connect', () => finish(true));
    socket.on('timeout', () => finish(false));
    socket.on('error', () => finish(false));
    socket.connect(port, host);
  });
}

function spawnProcess(command, args, name, options = {}) {
  const proc = spawn(command, args, {
    stdio: 'inherit',
    shell: isWindows,
    cwd: ROOT,
    env: { ...process.env },
    ...options,
  });
  proc.on('error', err => logErr(`[${name}] ${err.message}`));
  proc.on('exit', code => {
    if (code !== 0 && code !== null) {
      logErr(`[${name}] exited with code ${code}`);
    }
  });
  return proc;
}

// ── Steps ────────────────────────────────────────────────────────────

async function ensurePortsFree() {
  log(`Checking ports ${SERVER_PORT} (API) and ${CLIENT_PORT} (client)...`);

  const busy = await busyPortMessages([
    { port: SERVER_PORT, role: 'API server', override: '--api-port=<n> or SPECTEST_API_PORT=<n>' },
    { port: CLIENT_PORT, role: 'dev server', override: '--port=<n> or SPECTEST_PORT=<n>' },
  ]);
  if (busy.length > 0) {
    for (const msg of busy) logErr(msg);
    process.exit(1);
  }
  logOk(`Ports ${SERVER_PORT} and ${CLIENT_PORT} are available`);
}

async function ensureSpecCompiler() {
  log('Checking spec compiler...');
  const cliDist = path.join(SPEC_DIR, 'packages', 'cli', 'dist', 'index.js');
  const compilerDist = path.join(SPEC_DIR, 'packages', 'compiler', 'dist', 'compiler.js');

  const { existsSync } = await import('fs');
  if (!existsSync(compilerDist)) {
    logWarn('Spec compiler not built — building...');
    execSync('npm run build', { stdio: 'inherit', cwd: path.join(SPEC_DIR, 'packages', 'compiler') });
  }
  if (!existsSync(cliDist)) {
    logWarn('Spec CLI not built — building...');
    execSync('npm run build', { stdio: 'inherit', cwd: path.join(SPEC_DIR, 'packages', 'cli') });
  }
  logOk('Spec compiler ready');
}

async function checkHealth(port) {
  return new Promise(resolve => {
    const req = http.get(`http://localhost:${port}/api/meta`, res => {
      resolve(res.statusCode === 200);
    });
    req.on('error', () => resolve(false));
    req.setTimeout(2000, () => { req.destroy(); resolve(false); });
  });
}

async function startServers() {
  log(`Starting API server on port ${SERVER_PORT}...`);
  const api = spawnProcess('node', ['server.mjs'], 'api', {
    env: { ...process.env, PORT: String(SERVER_PORT) }
  });

  // Wait for API health
  let ready = false;
  for (let i = 0; i < 20; i++) {
    if (await tcpConnect('127.0.0.1', SERVER_PORT, 1000)) {
      ready = true;
      break;
    }
    await sleep(500);
  }

  if (!ready) {
    logErr('API server did not start in time');
    api.kill();
    process.exit(1);
  }
  logOk(`API server running on http://localhost:${SERVER_PORT}`);

  writeApiPortModule(path.join(ROOT, API_PORT_MODULE), SERVER_PORT);
  log(`Starting spec dev server on port ${CLIENT_PORT}...`);
  const client = spawnProcess('npx', ['spec', 'dev', '--port', String(CLIENT_PORT)], 'client');

  // Wait for client
  for (let i = 0; i < 30; i++) {
    if (await tcpConnect('127.0.0.1', CLIENT_PORT, 1000)) break;
    await sleep(500);
  }
  logOk(`Dev server available at http://localhost:${CLIENT_PORT}`);

  console.log('\n\x1b[36m══════════════════════════════════════════════════\x1b[0m');
  console.log(`\x1b[1m  Spectest\x1b[0m`);
  console.log(`  Frontend:  \x1b[32mhttp://localhost:${CLIENT_PORT}\x1b[0m`);
  console.log(`  API:       \x1b[32mhttp://localhost:${SERVER_PORT}\x1b[0m`);
  console.log('\x1b[36m══════════════════════════════════════════════════\x1b[0m');
  console.log('  Press Ctrl+C to stop all services\n');

  const shutdown = () => {
    console.log('\nShutting down...');
    if (isWindows) {
      try { execSync(`taskkill /PID ${client.pid} /T /F`, { stdio: 'ignore' }); } catch {}
      try { execSync(`taskkill /PID ${api.pid} /T /F`, { stdio: 'ignore' }); } catch {}
    } else {
      client.kill();
      api.kill();
    }
    process.exit(0);
  };

  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
  await new Promise(() => {});
}

// ── Main ─────────────────────────────────────────────────────────────

async function main() {
  console.log('\n\x1b[1mSpectest — Startup\x1b[0m\n');

  await ensurePortsFree();
  await ensureSpecCompiler();
  await startServers();
}

main().catch(err => {
  logErr('Startup failed: ' + err.message);
  process.exit(1);
});
