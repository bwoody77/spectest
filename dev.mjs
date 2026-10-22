/**
 * dev.mjs — Start mock API server + spec dev/prod server.
 *
 * Usage:
 *   pnpm dev        — dev server with hot reload
 *   pnpm dev --prod — production standalone JS bundle
 *
 * Ports (flag, else env var, else default):
 *   API server   --api-port=<n>  SPECTEST_API_PORT  default 4500
 *   app server   --port=<n>      SPECTEST_PORT      default 3000
 * (`--api-port <n>` and `--port <n>` work too.)
 *
 * The app's `source` endpoints are absolute URLs naming localhost:4500 (the
 * iOS views are emitted from them). On another API port the page reroutes
 * those calls before it mounts (src/api-origin.mjs): in dev mode src/boot.mjs
 * reads the port from the module this script writes (API_PORT_MODULE), and in
 * prod mode the HTML shell below names it.
 *
 * This script never stops a process it did not start. A busy port is refused
 * with the name of the process holding it, which is left running. The only
 * thing it stops is a server an earlier dev.mjs run started, recorded in
 * .dev-pids.json (see scripts/dev-ports.mjs for the rule). It used to
 * force-kill whatever held its ports, and its API port was 4000, which is
 * Vector's dev slot 0, so running it killed a Vector dev stack.
 */

import { spawn } from 'node:child_process';
import { createConnection } from 'node:net';
import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { existsSync, readFileSync, rmSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { gzip } from 'node:zlib';
import { promisify } from 'node:util';
import {
  DEFAULT_API_PORT,
  DEFAULT_CLIENT_PORT,
  resolvePort,
  busyPortMessages,
  stopOwnLeftovers,
  writePidFile,
  removePidFile,
  API_PORT_MODULE,
  apiPortModuleSource,
  writeApiPortModule,
} from './scripts/dev-ports.mjs';

const gzipAsync = promisify(gzip);
const ROOT = dirname(fileURLToPath(import.meta.url));
const PID_FILE = process.env.SPECTEST_DEV_PIDFILE || join(ROOT, '.dev-pids.json');
const SPEC_BIN = join(ROOT, 'node_modules', '@spec', 'cli', 'bin', 'spec.js');
const API_PORT_FILE = join(ROOT, API_PORT_MODULE);

// --- Parse CLI args ---
const args = process.argv.slice(2);

let API_PORT, CLIENT_PORT;
try {
  API_PORT = resolvePort(args, 'api-port', 'SPECTEST_API_PORT', DEFAULT_API_PORT);
  CLIENT_PORT = resolvePort(args, 'port', 'SPECTEST_PORT', DEFAULT_CLIENT_PORT);
} catch (err) {
  console.error(err.message);
  process.exit(1);
}
if (API_PORT === CLIENT_PORT) {
  console.error(`The API server and the app server cannot share port ${API_PORT}.`);
  process.exit(1);
}
const MODE = args.includes('--prod') ? 'prod' : 'dev';
const REGISTRY = args.find(a => a.startsWith('--registry'))?.split('=')[1]
  ?? (args.includes('--registry') ? args[args.indexOf('--registry') + 1] : undefined);

function waitForPort(port, timeoutMs = 15000) {
  const start = Date.now();
  return new Promise((resolve, reject) => {
    function check() {
      const sock = createConnection({ port, host: '127.0.0.1' });
      sock.on('connect', () => { sock.destroy(); resolve(); });
      sock.on('error', () => {
        if (Date.now() - start > timeoutMs) {
          reject(new Error(`Timed out waiting for port ${port}`));
        } else {
          setTimeout(check, 300);
        }
      });
    }
    check();
  });
}

// --- What this run started: recorded so a later run can stop it, and only it ---
const servers = [];
const children = [];
let stopping = false;

function record(role, pid, port) {
  servers.push({ role, pid, port });
  writePidFile(PID_FILE, { launcher: process.pid, mode: MODE, servers });
}

function own(child, role) {
  children.push(child);
  child.on('error', (err) => {
    if (stopping) return;
    console.error(`${role} failed to start: ${err.message}`);
    stop(1);
  });
  child.on('exit', (code, signal) => {
    if (stopping) return;
    console.error(`\n${role} exited (${signal ?? `code ${code}`}); stopping.`);
    stop(1);
  });
  return child;
}

function stop(code = 0) {
  if (stopping) return;
  stopping = true;
  for (const child of children) {
    try { child.kill(); } catch {}
  }
  removePidFile(PID_FILE);
  removeOwnApiPortModule();
  process.exit(code);
}

/** Remove the API port module, unless a later run has written its own port there. */
function removeOwnApiPortModule() {
  try {
    if (readFileSync(API_PORT_FILE, 'utf8') === apiPortModuleSource(API_PORT)) rmSync(API_PORT_FILE, { force: true });
  } catch {}
}

process.on('SIGINT', () => { console.log('\nShutting down...'); stop(0); });
process.on('SIGTERM', () => stop(0));

// --- Stop what an earlier dev.mjs run started, then refuse any port still busy ---
console.log('Checking ports...');
const { stopped } = await stopOwnLeftovers(PID_FILE);
for (const s of stopped) {
  console.log(`  Stopped the ${s.role} server an earlier dev.mjs run started (PID ${s.pid}, port ${s.port})`);
}

const busy = await busyPortMessages([
  { port: API_PORT, role: 'API server', override: '--api-port=<n> or SPECTEST_API_PORT=<n>' },
  { port: CLIENT_PORT, role: MODE === 'dev' ? 'dev server' : 'app server', override: '--port=<n> or SPECTEST_PORT=<n>' },
]);
if (busy.length > 0) {
  for (const msg of busy) console.error(`\n${msg}`);
  console.error('');
  process.exit(1);
}
console.log(`  Ports ${API_PORT} and ${CLIENT_PORT} are free`);

if (!existsSync(SPEC_BIN)) {
  console.error(`Spec CLI not found at ${SPEC_BIN}. Install dependencies first.`);
  process.exit(1);
}

// --- Start API server ---
console.log('\nStarting API server...');
const api = own(spawn(process.execPath, [join(ROOT, 'server.mjs')], {
  cwd: ROOT,
  stdio: 'inherit',
  env: { ...process.env, PORT: String(API_PORT) },
}), 'API server');
record('api', api.pid, API_PORT);

try {
  await waitForPort(API_PORT);
  console.log(`  API server ready on http://localhost:${API_PORT}`);
} catch {
  console.error('  ERROR: API server did not start in time');
  stop(1);
}

// ---------------------------------------------------------------------------
// Mode: dev (default) — hot-reload dev server
// ---------------------------------------------------------------------------
if (MODE === 'dev') {
  // src/boot.mjs reads it: the dev page's API calls go to API_PORT.
  writeApiPortModule(API_PORT_FILE, API_PORT);

  console.log('Starting spec dev server...');
  // Node runs the CLI directly (no shell, no pnpm wrapper), so the pid recorded
  // is the process that listens on the port.
  const devArgs = [SPEC_BIN, 'dev', '--port', String(CLIENT_PORT)];
  if (REGISTRY) devArgs.push('--registry', REGISTRY);
  const client = own(spawn(process.execPath, devArgs, { cwd: ROOT, stdio: 'inherit' }), 'Dev server');
  record('client', client.pid, CLIENT_PORT);

  try {
    // `spec dev` builds the whole app before it listens.
    await waitForPort(CLIENT_PORT, 120_000);
    console.log(`  Dev server ready on http://localhost:${CLIENT_PORT}`);
  } catch {
    console.error('  ERROR: Dev server did not start in time');
    stop(1);
  }

  console.log('\n=========================================');
  console.log(`  Mode:        development (hot reload)`);
  console.log(`  API server:  http://localhost:${API_PORT}`);
  console.log(`  Dev server:  http://localhost:${CLIENT_PORT}`);
  console.log('=========================================');
  console.log('\nPress Ctrl+C to stop both.\n');
}

// ---------------------------------------------------------------------------
// Mode: prod / byte — compile then serve static files
// ---------------------------------------------------------------------------
else {
  // --- Compile ---
  console.log('\nCompiling (production)...');
  const compile = spawn(process.execPath, [SPEC_BIN, 'compile', '--mode', 'prod', '--standalone'], { cwd: ROOT, stdio: 'inherit' });

  const compileOk = await new Promise((resolve) => {
    compile.on('close', (code) => resolve(code === 0));
    compile.on('error', () => resolve(false));
  });

  if (!compileOk) {
    console.error('  ERROR: production compilation failed');
    stop(1);
  }

  // --- Resolve paths for the static server ---
  const distDir = join(ROOT, 'dist');

  // --- HTML shell ---
  const PROD_HTML = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Spec — Production</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; }
    body { margin: 0; font-family: 'Inter', system-ui, -apple-system, sans-serif; color: #1e293b; background: #f8fafc; line-height: 1.5; -webkit-font-smoothing: antialiased; }
    #app { min-height: 100vh; }
  </style>
</head>
<body>
<div id="app"></div>
<script type="module">
  // Route the app's API calls to this run's API server before anything fetches.
  const { installApiPort } = await import('/src/api-origin.mjs');
  installApiPort(${API_PORT});

  // Load bundle first (sets up __specRegisterThemes global).
  const mod = await import('/bundle.js');

  // Pre-load saved theme before mounting to prevent flash.
  // @persist stores values via JSON.stringify, so strip surrounding quotes.
  let _theme = localStorage.getItem('spec-state-App.themePreset')
    || localStorage.getItem('spec-theme');
  if (_theme) _theme = _theme.replace(/^"|"$/g, '');
  if (_theme && _theme !== 'default') {
    try { await import('/themes/' + _theme + '.js'); } catch(e) {}
  }

  const mount = typeof mod.mountApp === 'function' ? mod.mountApp : null;
  if (mount) mount(document.getElementById('app'));
  else {
    const mounts = Object.entries(mod).filter(([k]) => k.startsWith('mount'));
    const fn = (mounts.find(([k]) => k === 'mountApp') || mounts[mounts.length - 1])?.[1];
    if (typeof fn === 'function') fn(document.getElementById('app'));
  }
</script>
</body>
</html>`;

  // --- Static file server ---
  const server = createServer(async (req, res) => {
    const url = req.url ?? '/';

    if (url === '/bundle.js') {
      try {
        const content = await readFile(join(distDir, 'bundle.js'));
        const acceptGzip = (req.headers['accept-encoding'] || '').includes('gzip');
        if (acceptGzip) {
          const compressed = await gzipAsync(content);
          res.writeHead(200, { 'Content-Type': 'application/javascript', 'Content-Encoding': 'gzip' });
          res.end(compressed);
        } else {
          res.writeHead(200, { 'Content-Type': 'application/javascript' });
          res.end(content);
        }
      } catch {
        res.writeHead(404);
        res.end('Not found');
      }
      return;
    }

    if (url === '/src/api-origin.mjs') {
      try {
        const content = await readFile(join(ROOT, 'src', 'api-origin.mjs'));
        res.writeHead(200, { 'Content-Type': 'application/javascript' });
        res.end(content);
      } catch {
        res.writeHead(404);
        res.end('Not found');
      }
      return;
    }

    // Serve theme files from dist/themes/
    if (url.startsWith('/themes/') && url.endsWith('.js')) {
      try {
        const content = await readFile(join(distDir, url));
        res.writeHead(200, { 'Content-Type': 'application/javascript' });
        res.end(content);
      } catch {
        res.writeHead(404);
        res.end('Not found');
      }
      return;
    }

    // Everything else → HTML shell
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(PROD_HTML);
  });

  server.on('error', (err) => {
    console.error(`  ERROR: app server could not listen on port ${CLIENT_PORT}: ${err.message}`);
    stop(1);
  });

  server.listen(CLIENT_PORT, '127.0.0.1', () => {
    // This process is the app server in prod mode.
    record('client', process.pid, CLIENT_PORT);
    console.log(`\n=========================================`);
    console.log(`  Mode:        production`);
    console.log(`  API server:  http://localhost:${API_PORT}`);
    console.log(`  App server:  http://localhost:${CLIENT_PORT}`);
    console.log('=========================================');
    console.log('\nPress Ctrl+C to stop both.\n');
  });
}
