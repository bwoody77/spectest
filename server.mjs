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
import { readFile } from 'node:fs/promises';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// ---------------------------------------------------------------------------
// In-memory data store
// ---------------------------------------------------------------------------

let nextNotificationId = 8;
let nextTaskId = 6;
let nextProductId = 21;

// ---------------------------------------------------------------------------
// Products — for DataGrid / EditableGrid demos
// ---------------------------------------------------------------------------

const products = [
  { id: 1,  name: 'Wireless Mouse',       category: 'Electronics', price: 29.99,  stock: 150,  status: 'active',       rating: 4.5, sku: 'WM-001' },
  { id: 2,  name: 'Mechanical Keyboard',   category: 'Electronics', price: 89.99,  stock: 75,   status: 'active',       rating: 4.8, sku: 'MK-002' },
  { id: 3,  name: 'USB-C Hub',            category: 'Electronics', price: 49.99,  stock: 200,  status: 'active',       rating: 4.2, sku: 'UH-003' },
  { id: 4,  name: 'Monitor Stand',        category: 'Furniture',   price: 39.99,  stock: 0,    status: 'out-of-stock', rating: 4.0, sku: 'MS-004' },
  { id: 5,  name: 'Desk Lamp',            category: 'Furniture',   price: 24.99,  stock: 120,  status: 'active',       rating: 4.3, sku: 'DL-005' },
  { id: 6,  name: 'Webcam HD',            category: 'Electronics', price: 59.99,  stock: 45,   status: 'active',       rating: 4.1, sku: 'WC-006' },
  { id: 7,  name: 'Noise-Cancel Headset', category: 'Audio',       price: 149.99, stock: 30,   status: 'active',       rating: 4.7, sku: 'NH-007' },
  { id: 8,  name: 'Bluetooth Speaker',    category: 'Audio',       price: 34.99,  stock: 0,    status: 'discontinued', rating: 3.9, sku: 'BS-008' },
  { id: 9,  name: 'Laptop Sleeve',        category: 'Accessories', price: 19.99,  stock: 300,  status: 'active',       rating: 4.4, sku: 'LS-009' },
  { id: 10, name: 'Phone Stand',          category: 'Accessories', price: 14.99,  stock: 250,  status: 'active',       rating: 4.6, sku: 'PS-010' },
  { id: 11, name: 'Cable Organizer',      category: 'Accessories', price: 9.99,   stock: 500,  status: 'active',       rating: 4.0, sku: 'CO-011' },
  { id: 12, name: 'Ergonomic Chair',      category: 'Furniture',   price: 299.99, stock: 15,   status: 'active',       rating: 4.9, sku: 'EC-012' },
  { id: 13, name: 'Standing Desk',        category: 'Furniture',   price: 449.99, stock: 8,    status: 'active',       rating: 4.7, sku: 'SD-013' },
  { id: 14, name: 'Desk Mat XL',          category: 'Accessories', price: 22.99,  stock: 180,  status: 'active',       rating: 4.3, sku: 'DM-014' },
  { id: 15, name: 'Wireless Charger',     category: 'Electronics', price: 29.99,  stock: 0,    status: 'out-of-stock', rating: 4.1, sku: 'WR-015' },
  { id: 16, name: 'Studio Microphone',    category: 'Audio',       price: 129.99, stock: 25,   status: 'active',       rating: 4.6, sku: 'SM-016' },
  { id: 17, name: 'Drawing Tablet',       category: 'Electronics', price: 199.99, stock: 40,   status: 'active',       rating: 4.5, sku: 'DT-017' },
  { id: 18, name: 'Portable SSD 1TB',     category: 'Electronics', price: 79.99,  stock: 60,   status: 'active',       rating: 4.8, sku: 'SS-018' },
  { id: 19, name: 'Earbuds Pro',          category: 'Audio',       price: 69.99,  stock: 90,   status: 'active',       rating: 4.4, sku: 'EP-019' },
  { id: 20, name: 'Desk Shelf',           category: 'Furniture',   price: 54.99,  stock: 35,   status: 'active',       rating: 4.2, sku: 'DS-020' },
];

// ---------------------------------------------------------------------------
// Categories — hierarchical tree data
// ---------------------------------------------------------------------------

const categories = [
  { id: 'root-1', label: 'Electronics', icon: 'cpu', children: [
    { id: 'elec-1', label: 'Computers', icon: 'monitor', children: [
      { id: 'comp-1', label: 'Laptops', icon: 'laptop' },
      { id: 'comp-2', label: 'Desktops', icon: 'monitor' },
      { id: 'comp-3', label: 'Tablets', icon: 'tablet' },
    ]},
    { id: 'elec-2', label: 'Peripherals', icon: 'mouse', children: [
      { id: 'peri-1', label: 'Keyboards', icon: 'keyboard' },
      { id: 'peri-2', label: 'Mice', icon: 'mouse' },
      { id: 'peri-3', label: 'Webcams', icon: 'camera' },
    ]},
    { id: 'elec-3', label: 'Storage', icon: 'hard-drive', children: [
      { id: 'stor-1', label: 'SSDs', icon: 'zap' },
      { id: 'stor-2', label: 'USB Drives', icon: 'usb' },
    ]},
  ]},
  { id: 'root-2', label: 'Audio', icon: 'headphones', children: [
    { id: 'aud-1', label: 'Headphones', icon: 'headphones' },
    { id: 'aud-2', label: 'Speakers', icon: 'speaker' },
    { id: 'aud-3', label: 'Microphones', icon: 'mic' },
  ]},
  { id: 'root-3', label: 'Furniture', icon: 'layout', children: [
    { id: 'furn-1', label: 'Desks', icon: 'square', children: [
      { id: 'desk-1', label: 'Standing Desks', icon: 'arrow-up' },
      { id: 'desk-2', label: 'Sit-Down Desks', icon: 'minus' },
    ]},
    { id: 'furn-2', label: 'Chairs', icon: 'user' },
    { id: 'furn-3', label: 'Lighting', icon: 'sun' },
  ]},
  { id: 'root-4', label: 'Accessories', icon: 'package', children: [
    { id: 'acc-1', label: 'Cases & Sleeves', icon: 'briefcase' },
    { id: 'acc-2', label: 'Stands & Mounts', icon: 'maximize' },
    { id: 'acc-3', label: 'Cable Management', icon: 'link' },
  ]},
];

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

  // GET /api/meta
  if (method === 'GET' && path === '/api/meta') {
    let versionData = {};
    try {
      const raw = await readFile(join(__dirname, 'version.json'), 'utf8');
      versionData = JSON.parse(raw);
    } catch {}
    return json(res, {
      app: 'spectest',
      version: versionData.version || '0.0.0',
      env: process.env.NODE_ENV || 'development',
      buildDate: versionData.buildDate || null,
      commit: versionData.commit || null,
      frameworkVersions: versionData.frameworkVersions || {},
    });
  }

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

  // GET /api/products/bulk?count=N
  if (method === 'GET' && path === '/api/products/bulk') {
    const count = parseInt(url.searchParams.get('count') || '10000', 10);
    const cats = ['Electronics', 'Audio', 'Furniture', 'Accessories'];
    const statuses = ['active', 'out-of-stock', 'discontinued'];
    const bulk = Array.from({ length: count }, (_, i) => ({
      id: i + 1,
      name: `Product ${i + 1}`,
      category: cats[i % cats.length],
      price: +(Math.random() * 500 + 5).toFixed(2),
      stock: Math.floor(Math.random() * 500),
      status: statuses[i % statuses.length],
      rating: +(Math.random() * 2 + 3).toFixed(1),
      sku: `BLK-${String(i + 1).padStart(5, '0')}`,
    }));
    console.log(`${method} ${req.url} -> 200 (${count} products)`);
    return json(res, bulk);
  }

  // GET /api/products
  if (method === 'GET' && path === '/api/products') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, products);
  }

  // GET /api/products/:id
  const productMatch = path.match(/^\/api\/products\/(\d+)$/);
  if (method === 'GET' && productMatch) {
    const product = products.find(p => p.id === parseInt(productMatch[1]));
    const status = product ? 200 : 404;
    console.log(`${method} ${req.url} -> ${status}`);
    return product ? json(res, product) : json(res, { error: 'Not found' }, 404);
  }

  // PUT /api/products/:id
  if (method === 'PUT' && productMatch) {
    const product = products.find(p => p.id === parseInt(productMatch[1]));
    if (!product) {
      console.log(`${method} ${req.url} -> 404`);
      return json(res, { error: 'Not found' }, 404);
    }
    const body = await readBody(req);
    Object.assign(product, body);
    console.log(`${method} ${req.url} -> 200`);
    return json(res, product);
  }

  // POST /api/products
  if (method === 'POST' && path === '/api/products') {
    const body = await readBody(req);
    const product = {
      id: nextProductId++,
      name: body.name || 'New Product',
      category: body.category || 'Uncategorized',
      price: body.price || 0,
      stock: body.stock || 0,
      status: body.status || 'active',
      rating: body.rating || 0,
      sku: body.sku || `NP-${nextProductId}`,
    };
    products.push(product);
    console.log(`${method} ${req.url} -> 201`);
    return json(res, product, 201);
  }

  // DELETE /api/products/:id
  if (method === 'DELETE' && productMatch) {
    const idx = products.findIndex(p => p.id === parseInt(productMatch[1]));
    if (idx === -1) {
      console.log(`${method} ${req.url} -> 404`);
      return json(res, { error: 'Not found' }, 404);
    }
    products.splice(idx, 1);
    console.log(`${method} ${req.url} -> 200`);
    return json(res, { ok: true });
  }

  // GET /api/categories
  if (method === 'GET' && path === '/api/categories') {
    console.log(`${method} ${req.url} -> 200`);
    return json(res, categories);
  }

  console.log(`${method} ${req.url} -> 404`);
  json(res, { error: 'Not found' }, 404);
});

const PORT = parseInt(process.env.PORT || '4000', 10);
const HOST = process.env.HOST || '127.0.0.1';
server.listen(PORT, HOST, () => {
  console.log(`Mock API server running at http://${HOST}:${PORT}`);
});
