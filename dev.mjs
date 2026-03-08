/**
 * dev.mjs — Start mock API server + spec dev/prod server.
 *
 * Usage:
 *   pnpm dev        — dev server with hot reload
 *   pnpm dev --prod — production standalone JS bundle
 *
 * Kills stale processes on the ports first, then starts both.
 */

import { spawn, execSync } from 'node:child_process';
import { createConnection } from 'node:net';
import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { gzip } from 'node:zlib';
import { promisify } from 'node:util';

const gzipAsync = promisify(gzip);

// --- Parse CLI args ---
const args = process.argv.slice(2);

const API_PORT = parseInt(args.find(a => a.startsWith('--api-port='))?.split('=')[1] ?? '4000');
const CLIENT_PORT = parseInt(args.find(a => a.startsWith('--port='))?.split('=')[1] ?? '3000');
const MODE = args.includes('--prod') ? 'prod' : 'dev';

function killPort(port) {
  try {
    const out = execSync(`netstat -ano`, { encoding: 'utf8' });
    const pids = new Set();
    for (const line of out.split('\n')) {
      if (line.includes(`:${port} `) && line.includes('LISTENING')) {
        const pid = line.trim().split(/\s+/).pop();
        if (pid && pid !== '0') pids.add(pid);
      }
    }
    for (const pid of pids) {
      console.log(`  Killing PID ${pid} on port ${port}`);
      try { execSync(`taskkill /F /PID ${pid}`, { stdio: 'ignore' }); } catch {}
    }
    return pids.size > 0;
  } catch {
    return false;
  }
}

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

// --- Kill stale processes ---
console.log('Checking for stale processes...');
if (killPort(API_PORT)) {
  console.log(`  Cleared port ${API_PORT}`);
} else {
  console.log(`  Port ${API_PORT} is free`);
}
if (killPort(CLIENT_PORT)) {
  console.log(`  Cleared port ${CLIENT_PORT}`);
} else {
  console.log(`  Port ${CLIENT_PORT} is free`);
}

// --- Start API server ---
console.log('\nStarting API server...');
const api = spawn('node', ['server.mjs'], { stdio: 'inherit' });
api.on('error', (err) => { console.error('API server failed:', err.message); process.exit(1); });

try {
  await waitForPort(API_PORT);
  console.log(`  API server ready on http://localhost:${API_PORT}`);
} catch {
  console.error('  ERROR: API server did not start in time');
  api.kill();
  process.exit(1);
}

// ---------------------------------------------------------------------------
// Mode: dev (default) — hot-reload dev server
// ---------------------------------------------------------------------------
if (MODE === 'dev') {
  console.log('Starting spec dev server...');
  const client = spawn('npx', ['spec', 'dev'], { stdio: 'inherit', shell: true });
  client.on('error', (err) => { console.error('Dev server failed:', err.message); process.exit(1); });

  try {
    await waitForPort(CLIENT_PORT);
    console.log(`  Dev server ready on http://localhost:${CLIENT_PORT}`);
  } catch {
    console.error('  ERROR: Dev server did not start in time');
    api.kill();
    client.kill();
    process.exit(1);
  }

  console.log('\n=========================================');
  console.log(`  Mode:        development (hot reload)`);
  console.log(`  API server:  http://localhost:${API_PORT}`);
  console.log(`  Dev server:  http://localhost:${CLIENT_PORT}`);
  console.log('=========================================');
  console.log('\nPress Ctrl+C to stop both.\n');

  function shutdown() {
    console.log('\nShutting down...');
    api.kill();
    client.kill();
    process.exit(0);
  }
  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}

// ---------------------------------------------------------------------------
// Mode: prod / byte — compile then serve static files
// ---------------------------------------------------------------------------
else {
  // --- Compile ---
  console.log('\nCompiling (production)...');
  const compile = spawn('npx', ['spec', 'compile', '--mode', 'prod', '--standalone'], { stdio: 'inherit', shell: true });

  const compileOk = await new Promise((resolve) => {
    compile.on('close', (code) => resolve(code === 0));
    compile.on('error', () => resolve(false));
  });

  if (!compileOk) {
    console.error('  ERROR: production compilation failed');
    api.kill();
    process.exit(1);
  }

  // --- Resolve paths for the static server ---
  const distDir = join(process.cwd(), 'dist');

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

  server.listen(CLIENT_PORT, '127.0.0.1', () => {
    console.log(`\n=========================================`);
    console.log(`  Mode:        production`);
    console.log(`  API server:  http://localhost:${API_PORT}`);
    console.log(`  App server:  http://localhost:${CLIENT_PORT}`);
    console.log('=========================================');
    console.log('\nPress Ctrl+C to stop both.\n');
  });

  function shutdown() {
    console.log('\nShutting down...');
    api.kill();
    server.close();
    process.exit(0);
  }
  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}
