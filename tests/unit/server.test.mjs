import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createServer } from 'node:http';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const SERVER_SCRIPT = join(__dirname, '..', '..', 'server.mjs');

let serverProcess;
let BASE_URL;

/**
 * Start the mock API server on a random available port.
 * We pick port 0 via the PORT env var — the server binds to whatever the OS
 * assigns, and we parse the port from its stdout banner.
 */
async function findFreePort() {
  return new Promise((resolve, reject) => {
    const s = createServer();
    s.listen(0, '127.0.0.1', () => {
      const port = s.address().port;
      s.close(() => resolve(port));
    });
    s.on('error', reject);
  });
}

beforeAll(async () => {
  const port = await findFreePort();
  BASE_URL = `http://127.0.0.1:${port}`;

  serverProcess = spawn(process.execPath, [SERVER_SCRIPT], {
    env: { ...process.env, PORT: String(port), HOST: '127.0.0.1' },
    stdio: ['ignore', 'pipe', 'pipe'],
  });

  // Wait for the server to print its "running at" banner
  await new Promise((resolve, reject) => {
    const timeout = setTimeout(() => reject(new Error('Server did not start in 10s')), 10_000);
    serverProcess.stdout.on('data', (data) => {
      if (data.toString().includes('running at')) {
        clearTimeout(timeout);
        resolve();
      }
    });
    serverProcess.on('error', (err) => {
      clearTimeout(timeout);
      reject(err);
    });
    serverProcess.on('exit', (code) => {
      clearTimeout(timeout);
      reject(new Error(`Server exited early with code ${code}`));
    });
  });
}, 15_000);

afterAll(() => {
  if (serverProcess) {
    serverProcess.kill('SIGTERM');
  }
});

/** Helper: fetch JSON from the mock API (always uses delay=0 for speed). */
async function api(path, options = {}) {
  const separator = path.includes('?') ? '&' : '?';
  const url = `${BASE_URL}${path}${separator}delay=0`;
  const res = await fetch(url, options);
  const body = await res.json();
  return { status: res.status, body };
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('GET /api/tasks', () => {
  it('returns 5 default tasks', async () => {
    const { status, body } = await api('/api/tasks');
    expect(status).toBe(200);
    expect(body).toHaveLength(5);
    expect(body[0]).toHaveProperty('id');
    expect(body[0]).toHaveProperty('title');
    expect(body[0]).toHaveProperty('status');
    expect(body[0]).toHaveProperty('assignee');
  });
});

describe('GET /api/tasks/:id', () => {
  it('returns a specific task by id', async () => {
    const { status, body } = await api('/api/tasks/1');
    expect(status).toBe(200);
    expect(body.id).toBe(1);
    expect(body.title).toBe('Set up project scaffolding');
  });

  it('returns 404 for a non-existent task', async () => {
    const { status, body } = await api('/api/tasks/9999');
    expect(status).toBe(404);
    expect(body.error).toBe('Not found');
  });
});

describe('POST /api/tasks', () => {
  it('creates a new task with auto-incrementing ID', async () => {
    const { status, body } = await api('/api/tasks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title: 'New test task', priority: 'high' }),
    });
    expect(status).toBe(201);
    expect(body.title).toBe('New test task');
    expect(body.priority).toBe('high');
    expect(body.status).toBe('todo');
    expect(body.id).toBeGreaterThanOrEqual(6);
  });
});

describe('PUT /api/tasks/:id', () => {
  it('updates an existing task', async () => {
    const { status, body } = await api('/api/tasks/2', {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'done' }),
    });
    expect(status).toBe(200);
    expect(body.id).toBe(2);
    expect(body.status).toBe('done');
  });

  it('returns 404 when updating a non-existent task', async () => {
    const { status, body } = await api('/api/tasks/9999', {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'done' }),
    });
    expect(status).toBe(404);
    expect(body.error).toBe('Not found');
  });
});

describe('DELETE /api/tasks/:id', () => {
  it('deletes an existing task', async () => {
    // First create a task to delete so we don't disrupt other tests
    const created = await api('/api/tasks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title: 'To be deleted' }),
    });
    const taskId = created.body.id;

    const { status, body } = await api(`/api/tasks/${taskId}`, {
      method: 'DELETE',
    });
    expect(status).toBe(200);
    expect(body.ok).toBe(true);

    // Confirm it's gone
    const after = await api(`/api/tasks/${taskId}`);
    expect(after.status).toBe(404);
  });

  it('returns 404 when deleting a non-existent task', async () => {
    const { status, body } = await api('/api/tasks/9999', {
      method: 'DELETE',
    });
    expect(status).toBe(404);
    expect(body.error).toBe('Not found');
  });
});

describe('GET /api/users', () => {
  it('returns 3 users', async () => {
    const { status, body } = await api('/api/users');
    expect(status).toBe(200);
    expect(body).toHaveLength(3);
    expect(body.map((u) => u.name)).toEqual(['Alice', 'Bob', 'Carol']);
  });
});

describe('GET /api/stats', () => {
  it('returns aggregated stats', async () => {
    const { status, body } = await api('/api/stats');
    expect(status).toBe(200);
    expect(body).toHaveProperty('total');
    expect(body).toHaveProperty('done');
    expect(body).toHaveProperty('inProgress');
    expect(body).toHaveProperty('todo');
    expect(body.users).toBe(3);
    // total should equal sum of done + inProgress + todo
    expect(body.total).toBe(body.done + body.inProgress + body.todo);
  });
});

describe('GET /api/notifications', () => {
  it('returns notifications array', async () => {
    const { status, body } = await api('/api/notifications');
    expect(status).toBe(200);
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBeGreaterThanOrEqual(7);
    expect(body[0]).toHaveProperty('id');
    expect(body[0]).toHaveProperty('title');
    expect(body[0]).toHaveProperty('severity');
    expect(body[0]).toHaveProperty('read');
  });
});

describe('PUT /api/notifications/:id/read', () => {
  it('marks a notification as read', async () => {
    const { status, body } = await api('/api/notifications/2/read', {
      method: 'PUT',
    });
    expect(status).toBe(200);
    expect(body.id).toBe(2);
    expect(body.read).toBe(true);
  });

  it('returns 404 for non-existent notification', async () => {
    const { status, body } = await api('/api/notifications/9999/read', {
      method: 'PUT',
    });
    expect(status).toBe(404);
    expect(body.error).toBe('Not found');
  });
});

describe('GET /api/activity', () => {
  it('returns 10 activity records', async () => {
    const { status, body } = await api('/api/activity');
    expect(status).toBe(200);
    expect(body).toHaveLength(10);
    expect(body[0]).toHaveProperty('type');
    expect(body[0]).toHaveProperty('user');
    expect(body[0]).toHaveProperty('detail');
    expect(body[0]).toHaveProperty('timestamp');
  });
});

describe('GET /api/products', () => {
  it('returns 20 default products', async () => {
    const { status, body } = await api('/api/products');
    expect(status).toBe(200);
    expect(body).toHaveLength(20);
    expect(body[0]).toHaveProperty('name');
    expect(body[0]).toHaveProperty('price');
    expect(body[0]).toHaveProperty('sku');
  });
});

describe('GET /api/categories', () => {
  it('returns hierarchical category tree', async () => {
    const { status, body } = await api('/api/categories');
    expect(status).toBe(200);
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(4); // Electronics, Audio, Furniture, Accessories

    // Check nested structure
    const electronics = body.find((c) => c.label === 'Electronics');
    expect(electronics).toBeDefined();
    expect(electronics.children).toBeDefined();
    expect(electronics.children.length).toBeGreaterThan(0);

    // Check deeper nesting
    const computers = electronics.children.find((c) => c.label === 'Computers');
    expect(computers).toBeDefined();
    expect(computers.children).toBeDefined();
    expect(computers.children.length).toBe(3);
  });
});

describe('?fail=true query param', () => {
  it('returns 500 error when fail=true is set', async () => {
    // Use raw fetch so our helper doesn't add delay twice
    const res = await fetch(`${BASE_URL}/api/tasks?fail=true&delay=0`);
    const body = await res.json();
    expect(res.status).toBe(500);
    expect(body.error).toBe('Simulated server error');
  });
});

describe('404 for non-existent routes', () => {
  it('returns 404 for unknown endpoint', async () => {
    const { status, body } = await api('/api/nonexistent');
    expect(status).toBe(404);
    expect(body.error).toBe('Not found');
  });
});
