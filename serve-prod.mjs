import { createServer } from 'http';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';

const bundle = readFileSync('dist/bundle.js', 'utf8');
const html = `<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><title>Spec Test</title></head>
<body>
<div id="app"></div>
<script type="module">
  // Load bundle first (sets up __specRegisterThemes global).
  const mod = await import('/bundle.js');

  // Pre-load saved theme before mounting (matches dev server behavior).
  // Must happen AFTER bundle load (which sets up the global registry)
  // but BEFORE mount (so theme is in registry when @persist restores it).
  const _theme = localStorage.getItem('spec-state-App.themePreset')
    || localStorage.getItem('spec-theme');
  if (_theme && _theme !== 'default' && _theme !== '"default"') {
    const clean = _theme.replace(/^"|"$/g, '');
    try { await import('/themes/' + clean + '.js'); } catch(e) {
      console.warn('[spec] theme preload failed for', clean, e);
    }
  }

  if (typeof mod.mountApp === 'function') {
    mod.mountApp(document.getElementById('app'));
  } else {
    console.error('[spec] mountApp not found in bundle');
  }
</script>
</body>
</html>`;

const server = createServer((req, res) => {
  res.setHeader('Cache-Control', 'no-store, no-cache');
  if (req.url === '/' || req.url === '/index.html') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(html);
  } else if (req.url === '/bundle.js') {
    res.writeHead(200, { 'Content-Type': 'application/javascript' });
    res.end(bundle);
  } else if (req.url.startsWith('/themes/') && req.url.endsWith('.js')) {
    const filePath = join('dist', req.url);
    if (existsSync(filePath)) {
      res.writeHead(200, { 'Content-Type': 'application/javascript' });
      res.end(readFileSync(filePath, 'utf8'));
    } else {
      res.writeHead(404);
      res.end('Not found');
    }
  } else {
    res.writeHead(404);
    res.end('Not found');
  }
});

server.listen(3333, () => console.log('Serving prod app at http://localhost:3333'));
