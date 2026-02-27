/**
 * Mock API server for spec admin dashboard testing.
 *
 * Endpoints:
 *   GET    /api/tasks        — list all tasks
 *   GET    /api/tasks/:id    — get a single task
 *   POST   /api/tasks        — create a task
 *   PUT    /api/tasks/:id    — update a task
 *   DELETE /api/tasks/:id    — delete a task
 *   GET    /api/users        — list all users
 *   GET    /api/stats        — dashboard stats
 *
 * Run: node server.mjs
 */

import { createServer } from 'node:http';

// ---------------------------------------------------------------------------
// In-memory data store
// ---------------------------------------------------------------------------

let nextTaskId = 6;

const tasks = [
  { id: 1, title: 'Set up project scaffolding',   status: 'done',        assignee: 'Alice',   priority: 'high',   createdAt: '2026-02-20' },
  { id: 2, title: 'Implement auth flow',          status: 'in-progress', assignee: 'Bob',     priority: 'high',   createdAt: '2026-02-21' },
  { id: 3, title: 'Design dashboard layout',      status: 'done',        assignee: 'Carol',   priority: 'medium', createdAt: '2026-02-22' },
  { id: 4, title: 'Write API integration tests',  status: 'todo',        assignee: 'Alice',   priority: 'medium', createdAt: '2026-02-23' },
  { id: 5, title: 'Deploy to staging',            status: 'todo',        assignee: 'Bob',     priority: 'low',    createdAt: '2026-02-24' },
];

const users = [
  { id: 1, name: 'Alice', role: 'admin',  email: 'alice@example.com' },
  { id: 2, name: 'Bob',   role: 'dev',    email: 'bob@example.com' },
  { id: 3, name: 'Carol', role: 'design', email: 'carol@example.com' },
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
}

function json(res, data, status = 200) {
  cors(res);
  res.writeHead(status, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify(data));
}

function readBody(req) {
  return new Promise((resolve) => {
    let body = '';
    req.on('data', (chunk) => { body += chunk; });
    req.on('end', () => {
      try { resolve(JSON.parse(body)); }
      catch { resolve({}); }
    });
  });
}

// Simulate network latency (200-500ms)
function delay() {
  return new Promise((r) => setTimeout(r, 200 + Math.random() * 300));
}

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

const server = createServer(async (req, res) => {
  cors(res);

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  await delay();

  const url = new URL(req.url, 'http://localhost');
  const path = url.pathname;
  const method = req.method;

  // GET /api/stats
  if (method === 'GET' && path === '/api/stats') {
    const done = tasks.filter(t => t.status === 'done').length;
    const inProgress = tasks.filter(t => t.status === 'in-progress').length;
    const todo = tasks.filter(t => t.status === 'todo').length;
    return json(res, { total: tasks.length, done, inProgress, todo, users: users.length });
  }

  // GET /api/users
  if (method === 'GET' && path === '/api/users') {
    return json(res, users);
  }

  // GET /api/tasks
  if (method === 'GET' && path === '/api/tasks') {
    return json(res, tasks);
  }

  // GET /api/tasks/:id
  const taskMatch = path.match(/^\/api\/tasks\/(\d+)$/);
  if (method === 'GET' && taskMatch) {
    const task = tasks.find(t => t.id === parseInt(taskMatch[1]));
    return task ? json(res, task) : json(res, { error: 'Not found' }, 404);
  }

  // POST /api/tasks
  if (method === 'POST' && path === '/api/tasks') {
    const body = await readBody(req);
    const task = {
      id: nextTaskId++,
      title: body.title || 'Untitled',
      status: body.status || 'todo',
      assignee: body.assignee || 'Unassigned',
      priority: body.priority || 'medium',
      createdAt: new Date().toISOString().slice(0, 10),
    };
    tasks.push(task);
    return json(res, task, 201);
  }

  // PUT /api/tasks/:id
  if (method === 'PUT' && taskMatch) {
    const task = tasks.find(t => t.id === parseInt(taskMatch[1]));
    if (!task) return json(res, { error: 'Not found' }, 404);
    const body = await readBody(req);
    Object.assign(task, body);
    return json(res, task);
  }

  // DELETE /api/tasks/:id
  if (method === 'DELETE' && taskMatch) {
    const idx = tasks.findIndex(t => t.id === parseInt(taskMatch[1]));
    if (idx === -1) return json(res, { error: 'Not found' }, 404);
    tasks.splice(idx, 1);
    return json(res, { ok: true });
  }

  json(res, { error: 'Not found' }, 404);
});

const PORT = 4000;
server.listen(PORT, '127.0.0.1', () => {
  console.log(`Mock API server running at http://localhost:${PORT}`);
});
