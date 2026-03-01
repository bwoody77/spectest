/**
 * dev.mjs — Start mock API server + spec dev/prod/bytecode server.
 *
 * Usage:
 *   pnpm dev          — dev server with hot reload (default)
 *   pnpm dev --prod   — production standalone JS bundle
 *   pnpm dev --byte   — production bytecode (.specbc) bundle
 *
 * Kills stale processes on the ports first, then starts both.
 */

import { spawn, execSync } from 'node:child_process';
import { createConnection } from 'node:net';
import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { join, dirname } from 'node:path';
import { createRequire } from 'node:module';

const API_PORT = 4000;
const CLIENT_PORT = 3000;

// --- Parse CLI args ---
const args = process.argv.slice(2);
const MODE = args.includes('--byte') ? 'byte'
           : args.includes('--prod') ? 'prod'
           : 'dev';

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
  const isBytecode = MODE === 'byte';
  const label = isBytecode ? 'bytecode' : 'production';

  // --- Compile ---
  console.log(`\nCompiling (${label})...`);
  const compileArgs = isBytecode
    ? ['spec', 'compile', '--mode', 'prod', '--bytecode']
    : ['spec', 'compile', '--mode', 'prod', '--standalone'];
  const compile = spawn('npx', compileArgs, { stdio: 'inherit', shell: true });

  const compileOk = await new Promise((resolve) => {
    compile.on('close', (code) => resolve(code === 0));
    compile.on('error', () => resolve(false));
  });

  if (!compileOk) {
    console.error(`  ERROR: ${label} compilation failed`);
    api.kill();
    process.exit(1);
  }

  // --- Resolve paths for the static server ---
  const distDir = join(process.cwd(), 'dist');

  // For prod mode, the standalone bundle.js is self-contained (no import map needed).
  // For byte mode, we need the VM to load and execute the .specbc file.

  // Resolve @spec/vm dist path for bytecode mode
  let vmDir = '';
  if (isBytecode) {
    try {
      const require = createRequire(import.meta.url);
      const vmMain = require.resolve('@spec/vm');
      vmDir = dirname(vmMain);
    } catch {
      // Fallback: relative to the spec monorepo
      vmDir = join(process.cwd(), '..', 'spec', 'packages', 'vm', 'dist');
    }
  }

  // --- Build HTML shells ---
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
  import { mountApp } from '/bundle.js';
  const mount = typeof mountApp === 'function' ? mountApp : null;
  if (mount) mount(document.getElementById('app'));
  else {
    // Fallback: find any mount* export
    const mod = await import('/bundle.js');
    const mounts = Object.entries(mod).filter(([k]) => k.startsWith('mount'));
    const fn = (mounts.find(([k]) => k === 'mountApp') || mounts[mounts.length - 1])?.[1];
    if (typeof fn === 'function') fn(document.getElementById('app'));
  }
</script>
</body>
</html>`;

  const BYTE_HTML = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Spec — Bytecode</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; }
    body { margin: 0; font-family: 'Inter', system-ui, -apple-system, sans-serif; color: #1e293b; background: #f8fafc; line-height: 1.5; -webkit-font-smoothing: antialiased; }
    #app { min-height: 100vh; }
  </style>
</head>
<body>
<div id="app"></div>
<script type="module">
  import { loadAndMount } from '/@spec/vm/index.js';
  await loadAndMount('/bundle.specbc', document.getElementById('app'));
</script>
</body>
</html>`;

  // --- Static file server ---
  const server = createServer(async (req, res) => {
    const url = req.url ?? '/';

    // Serve VM files (bytecode mode)
    if (isBytecode && url.startsWith('/@spec/vm/')) {
      const filename = url.slice('/@spec/vm/'.length);
      if (/^[a-z-]+\.js$/.test(filename)) {
        try {
          const content = await readFile(join(vmDir, filename), 'utf8');
          res.writeHead(200, { 'Content-Type': 'application/javascript' });
          res.end(content);
        } catch {
          res.writeHead(404);
          res.end('Not found');
        }
        return;
      }
    }

    // Serve the compiled bundle
    if (url === '/bundle.js' && !isBytecode) {
      try {
        const content = await readFile(join(distDir, 'bundle.js'), 'utf8');
        res.writeHead(200, { 'Content-Type': 'application/javascript' });
        res.end(content);
      } catch {
        res.writeHead(404);
        res.end('Not found');
      }
      return;
    }

    // Serve the bytecode bundle
    if (url === '/bundle.specbc' && isBytecode) {
      try {
        const content = await readFile(join(distDir, 'bundle.specbc'));
        res.writeHead(200, { 'Content-Type': 'application/octet-stream' });
        res.end(content);
      } catch {
        res.writeHead(404);
        res.end('Not found');
      }
      return;
    }

    // Everything else → HTML shell
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(isBytecode ? BYTE_HTML : PROD_HTML);
  });

  server.listen(CLIENT_PORT, '127.0.0.1', () => {
    console.log(`\n=========================================`);
    console.log(`  Mode:        ${label}`);
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
