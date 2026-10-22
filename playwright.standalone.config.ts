import { defineConfig } from '@playwright/test';

/**
 * Playwright config for the SELF-CONTAINED e2e tests — the ones that compile
 * their own `--standalone` fixture and inject it with `addScriptTag`.
 *
 * ── Why this exists ─────────────────────────────────────────────────────────
 * The default config starts `node dev.mjs --prod` as a `webServer` and will not
 * run a single test until that build succeeds. The standalone tests never touch
 * it: they stage a fixture outside both repos, compile it with the CLI under
 * test, and drive `about:blank`. Coupling them to the app build means an
 * unrelated defect in the app takes the component tests down with it: on
 * 2026-08-11 an app build failure (fixed in spec, Vector #1278) made BOTH
 * grid-drag suites unrunnable despite their having nothing to do with it.
 *
 * Run with:
 *
 *     npx playwright test --config playwright.standalone.config.ts \
 *       tests/e2e/grid-column-reorder.spec.ts
 *
 * Everything else keeps using the default config. This is a narrower harness,
 * not a replacement: a test that needs the real app still needs the server.
 */
export default defineConfig({
  testDir: './tests/e2e',
  timeout: 30_000,
  expect: { timeout: 10_000 },
  fullyParallel: false,
  workers: 1,
  retries: 1,
  reporter: 'list',

  use: {
    headless: true,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [{ name: 'chromium', use: { browserName: 'chromium' } }],

  // No `webServer`, and no `baseURL`: these tests navigate to about:blank.
});
