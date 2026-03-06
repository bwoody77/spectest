import { resolve } from 'path';
import { pathToFileURL } from 'url';
import { createRequire } from 'module';

const esbuildPath = 'C:/projects/spec/node_modules/.pnpm/esbuild@0.21.5/node_modules/esbuild/lib/main.js';
const { build } = await import(pathToFileURL(esbuildPath).href);

const cliRequire = createRequire(pathToFileURL(resolve('C:/projects/spec/packages/cli/dist/commands/compile.js')).href);
const runtimeIndex = cliRequire.resolve('@spec/runtime');
const componentsIndex = cliRequire.resolve('@spec/components');
const runtimeDir = resolve(runtimeIndex, '..');
const componentsDir = resolve(componentsIndex, '..');

const result = await build({
  entryPoints: ['dist-test/bundle.js'],
  bundle: true,
  format: 'esm',
  write: false,
  minify: true,  // WITH minification
  alias: { '@spec/runtime': runtimeDir + '/index.js' },
  plugins: [{
    name: 'spec-components-resolver',
    setup(b) {
      b.onResolve({ filter: /^@spec\/components/ }, (args) => {
        const subpath = args.path.replace('@spec/components', '');
        return { path: resolve(componentsDir, '.' + (subpath || '/index.js')) };
      });
      b.onResolve({ filter: /^@spec\/runtime/ }, (args) => {
        const subpath = args.path.replace('@spec/runtime', '');
        return { path: resolve(runtimeDir, '.' + (subpath || '/index.js')) };
      });
      b.onResolve({ filter: /^\/themes\// }, (args) => {
        return { path: args.path, external: true };
      });
      b.onResolve({ filter: /^\/[^@]/ }, (args) => {
        return { path: resolve(process.cwd(), '.' + args.path) };
      });
    },
  }],
});

const text = result.outputFiles[0].text;

// Count occurrences of applyStrangerThemes
const count = (text.match(/applyStrangerThemes/g) || []).length;
console.log('applyStrangerThemes occurrences:', count);

if (count > 0) {
  let idx = 0;
  while ((idx = text.indexOf('applyStrangerThemes', idx)) !== -1) {
    const start = Math.max(0, idx - 60);
    const end = Math.min(text.length, idx + 60);
    console.log('  context:', text.substring(start, end));
    idx += 1;
  }
}

// Find what esbuild renamed applyStrangerThemes to
// Look around the strangerThingsTransition call in unminified, then search the pattern
// In unminified: strangerThingsTransition(applyStrangerThemes)
// In minified Qi is strangerThingsTransition. Let's find Qi( calls
const qiCalls = text.match(/Qi\([^)]{0,30}\)/g);
if (qiCalls) {
  console.log('Qi() calls:', qiCalls);
}

// Let's find what's near 'stranger-things' in the minified code  
const stIdx = text.indexOf('Qi(');
if (stIdx !== -1) {
  const start = Math.max(0, stIdx - 10);
  const end = Math.min(text.length, stIdx + 60);
  console.log('Near Qi call:', text.substring(start, end));
}
