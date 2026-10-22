/**
 * Point the app's API calls at the API server dev.mjs started.
 *
 * The .spec sources (and the iOS views emitted from them) name the API as
 * http://localhost:4500, the default port. When dev.mjs runs with
 * --api-port=<n>, the page calls installApiPort(n) before it mounts the app,
 * and every fetch to that origin goes to port n instead. The Spec runtime
 * calls the global fetch for `source` endpoints and `await fetch(...)` alike,
 * so one wrapper covers both.
 *
 * Browser module: no Node imports. Served at /src/api-origin.mjs by `spec dev`
 * and by dev.mjs --prod.
 */

/** The port the .spec sources name. Equal to DEFAULT_API_PORT in scripts/dev-ports.mjs. */
export const SOURCE_API_PORT = 4500;

const SOURCE_ORIGINS = [`http://localhost:${SOURCE_API_PORT}`, `http://127.0.0.1:${SOURCE_API_PORT}`];

/** `url` with the sources' API origin moved to `port`; any other URL unchanged. */
export function rewriteApiUrl(url, port) {
  if (port === SOURCE_API_PORT) return url;
  for (const origin of SOURCE_ORIGINS) {
    const rest = url.slice(origin.length);
    if (url.startsWith(origin) && (rest === '' || rest[0] === '/' || rest[0] === '?')) {
      return origin.slice(0, -String(SOURCE_API_PORT).length) + port + rest;
    }
  }
  return url;
}

/** Wrap `target.fetch` so the app's API calls reach `port`. A no-op on the default port. */
export function installApiPort(port, target = globalThis) {
  if (port === SOURCE_API_PORT) return;
  const original = target.fetch;
  target.fetch = function fetchOnApiPort(input, init) {
    if (typeof input === 'string') {
      input = rewriteApiUrl(input, port);
    } else if (input instanceof URL) {
      input = rewriteApiUrl(input.href, port);
    } else if (input && typeof input.url === 'string') {
      const url = rewriteApiUrl(input.url, port);
      if (url !== input.url) input = new Request(url, input);
    }
    return original.call(target, input, init);
  };
}
