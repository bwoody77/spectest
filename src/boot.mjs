/**
 * Dev-page entry point. The `spec dev` shell probes for /src/boot.mjs and, when
 * it exists, imports it instead of mounting the bundle itself.
 *
 * It routes the app's API calls to the port dev.mjs was started with (see
 * api-origin.mjs), then mounts the app the way the shell would. dev.mjs writes
 * that port to /.dev-api-port.mjs before it starts `spec dev`; a bare
 * `spec dev` has none and keeps the default port.
 */
import { installApiPort, SOURCE_API_PORT } from './api-origin.mjs';

let apiPort = SOURCE_API_PORT;
try {
  ({ API_PORT: apiPort } = await import('/.dev-api-port.mjs'));
} catch {}
installApiPort(apiPort);

const mod = await import('/bundle.js');
const mounts = Object.entries(mod).filter(([k]) => k.startsWith('mount'));
const mountFn = (mounts.find(([k]) => k === 'mountApp') || mounts[mounts.length - 1])?.[1];
if (typeof mountFn === 'function') mountFn(document.getElementById('app'));
