import { exec } from 'child_process';
import http from 'http';

function fetch(path) {
  return new Promise((resolve) => {
    http.get('http://localhost:3000' + path, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', () => resolve(''));
  });
}

const server = exec('node dev.mjs', { cwd: 'C:/projects/spectest' });

setTimeout(async () => {
  const html = await fetch('/');
  // Extract just the script tag content
  const scriptMatch = html.match(/<script type="module">([\s\S]*?)<\/script>/);
  if (scriptMatch) {
    console.log('=== BOOT SCRIPT ===');
    console.log(scriptMatch[1]);
  } else {
    console.log('No script found. HTML length:', html.length);
    console.log('First 500 chars:', html.substring(0, 500));
  }

  server.kill();
  process.exit(0);
}, 20000);
