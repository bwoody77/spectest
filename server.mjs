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

let nextNotificationId = 8;
let nextTaskId = 6;

const notifications = [
  { id: 1, title: 'Deployment succeeded',       severity: 'success', read: true,  createdAt: '2026-02-26T09:00:00Z' },
  { id: 2, title: 'Build failed on main',       severity: 'error',   read: false, createdAt: '2026-02-26T08:45:00Z' },
  { id: 3, title: 'PR #42 awaiting review',     severity: 'warning', read: false, createdAt: '2026-02-25T16:30:00Z' },
  { id: 4, title: 'New team member joined',      severity: 'info',    read: true,  createdAt: '2026-02-25T14:00:00Z' },
  { id: 5, title: 'Security patch available',    severity: 'warning', read: false, createdAt: '2026-02-25T11:00:00Z' },
  { id: 6, title: 'Database backup completed',   severity: 'success', read: true,  createdAt: '2026-02-24T22:00:00Z' },
  { id: 7, title: 'Rate limit threshold reached',severity: 'error',   read: false, createdAt: '2026-02-24T18:30:00Z' },
];

const activity = [
  { id: 1, type: 'task_created',   user: 'Alice', detail: 'Created "Set up project scaffolding"', timestamp: '2026-02-26T09:15:00Z' },
  { id: 2, type: 'task_completed', user: 'Alice', detail: 'Completed "Set up project scaffolding"', timestamp: '2026-02-26T09:10:00Z' },
  { id: 3, type: 'comment',        user: 'Bob',   detail: 'Commented on "Implement auth flow"',    timestamp: '2026-02-26T08:50:00Z' },
  { id: 4, type: 'task_assigned',  user: 'Carol', detail: 'Assigned to "Design dashboard layout"', timestamp: '2026-02-25T17:00:00Z' },
  { id: 5, type: 'deploy',         user: 'Alice', detail: 'Deployed v1.2.0 to staging',            timestamp: '2026-02-25T15:30:00Z' },
  { id: 6, type: 'task_created',   user: 'Bob',   detail: 'Created "Write API integration tests"', timestamp: '2026-02-25T14:20:00Z' },
  { id: 7, type: 'comment',        user: 'Carol', detail: 'Commented on "Deploy to staging"',      timestamp: '2026-02-25T12:00:00Z' },
  { id: 8, type: 'task_assigned',  user: 'Alice', detail: 'Assigned to "Deploy to staging"',       timestamp: '2026-02-25T10:00:00Z' },
  { id: 9, type: 'deploy',         user: 'Bob',   detail: 'Deployed v1.1.0 to production',         timestamp: '2026-02-24T20:00:00Z' },
  { id: 10, type: 'task_completed', user: 'Carol', detail: 'Completed "Design dashboard layout"',  timestamp: '2026-02-24T18:00:00Z' },
];

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

// Simulate network latency (default 200-500ms, overridable via ?delay=ms)
function delay(ms) {
  const wait = ms != null ? ms : 200 + Math.random() * 300;
  return new Promise((r) => setTimeout(r, wait));
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

  const url = new URL(req.url, 'http://localhost');
  const path = url.pathname;
  const method = req.method;

  // --- Test simulation query params ---
  const delayMs = url.searchParams.has('delay') ? parseInt(url.searchParams.get('delay'), 10) : undefined;
  const shouldFail = url.searchParams.get('fail') === 'true';
  const failRate = url.searchParams.has('failRate') ? parseFloat(url.searchParams.get('failRate')) : 0;

  // Apply delay (custom or default 200-500ms)
  await delay(delayMs);

  // Forced failure
  if (shouldFail) {
    console.log(`${method} ${req.url} -> 500 (fail=true)`);
    return json(res, { error: 'Simulated server error' }, 500);
  }

  // Random failure based on failRate
  if (failRate > 0 && Math.random() < failRate) {
    console.log(`${method} ${req.url} -> 500 (failRate=${failRate})`);
    return json(res, { error: 'Random simulated failure' }, 500);
  }

  // --- Routing ---

  // GET /api/activity
  if (method === 'GET' && path === '/api/activity') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, activity);
  }

  // GET /api/notifications
  if (method === 'GET' && path === '/api/notifications') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, notifications);
  }

  // PUT /api/notifications/:id/read
  const notifMatch = path.match(/^\/api\/notifications\/(\d+)\/read$/);
  if (method === 'PUT' && notifMatch) {
    const notif = notifications.find(n => n.id === parseInt(notifMatch[1]));
    if (!notif) return json(res, { error: 'Not found' }, 404);
    notif.read = true;
    console.log(`${method} ${req.url} -> 200`);
    return json(res, notif);
  }

  // GET /api/stats
  if (method === 'GET' && path === '/api/stats') {
    const done = tasks.filter(t => t.status === 'done').length;
    const inProgress = tasks.filter(t => t.status === 'in-progress').length;
    const todo = tasks.filter(t => t.status === 'todo').length;
    console.log(`${method} ${req.url} -> 200`);
    return json(res, { total: tasks.length, done, inProgress, todo, users: users.length });
  }

  // GET /api/users
  if (method === 'GET' && path === '/api/users') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, users);
  }

  // GET /api/tasks
  if (method === 'GET' && path === '/api/tasks') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, tasks);
  }

  // GET /api/tasks/:id
  const taskMatch = path.match(/^\/api\/tasks\/(\d+)$/);
  if (method === 'GET' && taskMatch) {
    const task = tasks.find(t => t.id === parseInt(taskMatch[1]));
    const status = task ? 200 : 404;
    console.log(`${method} ${req.url} -> ${status}`);
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
    console.log(`${method} ${req.url} -> 201`);
    return json(res, task, 201);
  }

  // PUT /api/tasks/:id
  if (method === 'PUT' && taskMatch) {
    const task = tasks.find(t => t.id === parseInt(taskMatch[1]));
    if (!task) {
      console.log(`${method} ${req.url} -> 404`);
      return json(res, { error: 'Not found' }, 404);
    }
    const body = await readBody(req);
    Object.assign(task, body);
    console.log(`${method} ${req.url} -> 200`);
    return json(res, task);
  }

  // DELETE /api/tasks/:id
  if (method === 'DELETE' && taskMatch) {
    const idx = tasks.findIndex(t => t.id === parseInt(taskMatch[1]));
    if (idx === -1) {
      console.log(`${method} ${req.url} -> 404`);
      return json(res, { error: 'Not found' }, 404);
    }
    tasks.splice(idx, 1);
    console.log(`${method} ${req.url} -> 200`);
    return json(res, { ok: true });
  }

  console.log(`${method} ${req.url} -> 404`);
  json(res, { error: 'Not found' }, 404);
});

const PORT = 4000;
server.listen(PORT, '127.0.0.1', () => {
  console.log(`Mock API server running at http://localhost:${PORT}`);
});
