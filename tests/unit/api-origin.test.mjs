/**
 * The app's API URLs name localhost:4500 in the .spec sources (and in the
 * emitted iOS views), so a dev.mjs run with --api-port=<n> reroutes them in the
 * browser instead: src/api-origin.mjs wraps window.fetch before the app mounts.
 */
import { describe, it, expect } from 'vitest';
import { rewriteApiUrl, installApiPort, SOURCE_API_PORT } from '../../src/api-origin.mjs';
import { DEFAULT_API_PORT, apiPortModuleSource } from '../../scripts/dev-ports.mjs';

describe('rewriteApiUrl', () => {
  it('moves the sources\' API origin to the given port', () => {
    expect(rewriteApiUrl('http://localhost:4500/api/tasks', 4600)).toBe('http://localhost:4600/api/tasks');
    expect(rewriteApiUrl('http://localhost:4500/api/products/bulk?count=10', 4600))
      .toBe('http://localhost:4600/api/products/bulk?count=10');
    expect(rewriteApiUrl('http://127.0.0.1:4500/api/stats', 4600)).toBe('http://127.0.0.1:4600/api/stats');
  });

  it('leaves the URL alone on the default port', () => {
    expect(rewriteApiUrl('http://localhost:4500/api/tasks', 4500)).toBe('http://localhost:4500/api/tasks');
  });

  it('leaves every other URL alone', () => {
    for (const url of [
      '/bundle.js',
      'http://localhost:3000/api/tasks',
      'http://localhost:45001/api/tasks',
      'https://localhost:4500/api/tasks',
      'http://example.com/http://localhost:4500/api/tasks',
    ]) {
      expect(rewriteApiUrl(url, 4600)).toBe(url);
    }
  });
});

describe('installApiPort', () => {
  function fakeWindow() {
    const calls = [];
    const target = { fetch(input, init) { calls.push({ input, init, self: this }); return Promise.resolve('ok'); } };
    return { target, calls };
  }

  it('sends the app\'s API calls to the given port, keeping the request options', async () => {
    const { target, calls } = fakeWindow();
    installApiPort(4600, target);

    const init = { method: 'DELETE' };
    expect(await target.fetch('http://localhost:4500/api/tasks/7', init)).toBe('ok');
    await target.fetch(new URL('http://localhost:4500/api/stats'));
    await target.fetch(new Request('http://localhost:4500/api/tasks', { method: 'POST', body: '{}' }));

    expect(calls[0].input).toBe('http://localhost:4600/api/tasks/7');
    expect(calls[0].init).toBe(init);
    expect(calls[0].self).toBe(target);
    expect(calls[1].input).toBe('http://localhost:4600/api/stats');
    expect(calls[2].input.url).toBe('http://localhost:4600/api/tasks');
    expect(calls[2].input.method).toBe('POST');
  });

  it('passes every other request through untouched', async () => {
    const { target, calls } = fakeWindow();
    installApiPort(4600, target);
    await target.fetch('/src/boot.mjs', { method: 'HEAD' });
    expect(calls[0].input).toBe('/src/boot.mjs');
  });

  it('does not wrap fetch on the default port', () => {
    const { target } = fakeWindow();
    const original = target.fetch;
    installApiPort(4500, target);
    expect(target.fetch).toBe(original);
  });
});

describe('the port dev.mjs hands the page', () => {
  it('is the port the sources name when no --api-port is given', () => {
    expect(SOURCE_API_PORT).toBe(DEFAULT_API_PORT);
  });

  it('is written as a module the dev page imports', async () => {
    const src = apiPortModuleSource(4600);
    const mod = await import('data:text/javascript,' + encodeURIComponent(src));
    expect(mod.API_PORT).toBe(4600);
  });
});
