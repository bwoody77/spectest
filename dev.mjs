/**
 * dev.mjs — Start mock API server + spec dev server.
 * Kills stale processes on the ports first, then starts both.
 */

import { spawn, execSync } from 'node:child_process';
import { createConnection } from 'node:net';

const API_PORT = 4000;
const CLIENT_PORT = 3000;

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

// --- Start dev server ---
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

// --- Summary ---
console.log('\n=========================================');
console.log(`  API server:  http://localhost:${API_PORT}`);
console.log(`  Dev server:  http://localhost:${CLIENT_PORT}`);
console.log('=========================================');
console.log('\nPress Ctrl+C to stop both.\n');

// --- Cleanup on exit ---
function shutdown() {
  console.log('\nShutting down...');
  api.kill();
  client.kill();
  process.exit(0);
}
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
