/**
 * DataGridSpec column drag-to-reorder — real-layout test.
 *
 * ── Why this file exists ────────────────────────────────────────────────────
 * The component suite runs in happy-dom, which computes NO geometry:
 * `getBoundingClientRect()` returns all zeros there, so `gapFromX` can never
 * be wrong and a drag can never be exercised. Everything the drag actually
 * depends on — column left edges, widths, the 20% direction-dependent entry
 * threshold, the 5px click-vs-drag threshold — is invisible to it. This is
 * the only place the wire is driven for real.
 *
 * ── Harness: `--standalone` + `addScriptTag` ────────────────────────────────
 * `data-grid-spec.spec` carries a path-based `@extern`
 * (`@spec/components/data-grid-column-drag.js`), which raised the question of
 * whether `--standalone` still emits zero bare imports. It does. Measured on
 * 2026-08-10 against the compiled fixture:
 *
 *     grep -c "@spec/components" <OUT>/bundle.js   →  0
 *
 * `bundleStandalone`'s esbuild plugin resolves `@spec/components/*` through
 * `require.resolve('@spec/components')` and inlines the whole graph
 * (`data-grid-column-drag.js` → `column-reorder-math.js`, `column-ghost.js`,
 * `drag-core/pointer.js` → `drag-core/shared.js`). So this file takes the
 * `addScriptTag` branch and needs no dev server; the `spec dev --registry`
 * fallback described in the plan was not needed.
 *
 * The bundle is plain ESM with named exports and no side-effect global, so it
 * is injected as a module with a one-line epilogue publishing the mount
 * functions on `window`. The output file is `bundle.js`, not `bundle.en.js` —
 * `--locales` only splits the output when the project declares `@i18n`, and
 * this fixture does not.
 *
 * ── Why it does NOT go through `spectest/src/app.spec` ──────────────────────
 * That path resolves components from `.spec-packages/`, a cache that has
 * silently tested a version four minor releases old. The fixture is compiled
 * from the component's REAL source on every run.
 *
 * ── SPEC_REPO ──────────────────────────────────────────────────────────────
 * Defaults to `C:/projects/spec`. Point it at a worktree to test unmerged
 * component work:
 *
 *     SPEC_REPO=C:/projects/spec-worktrees/grid-column-reorder npx playwright \
 *       test tests/e2e/grid-column-reorder.spec.ts
 *
 * Both the CLI and the component `.spec` sources are taken from there, so the
 * bundle can never be a mix of two checkouts.
 */

import { test, expect, type Page } from '@playwright/test';
import { execFileSync } from 'node:child_process';
import { mkdtempSync, mkdirSync, copyFileSync, readFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = dirname(fileURLToPath(import.meta.url));
const FIXTURE = join(HERE, '..', '..', 'fixtures', 'column-reorder', 'host.spec');
const SPEC_REPO = (process.env.SPEC_REPO ?? 'C:/projects/spec').replace(/\\/g, '/');

/** Component sources the fixture needs, compiled from source alongside it. */
const COMPONENT_SPECS = ['data-grid-spec.spec', 'checkbox.spec'];

let bundleSrc = '';
let stageDir = '';

test.beforeAll(() => {
  // Stage outside both repos: the fixture surface plus the component sources
  // it uses, compiled as one project. Nothing is resolved from a cache.
  stageDir = mkdtempSync(join(tmpdir(), 'spec-column-reorder-'));
  const src = join(stageDir, 'src');
  const out = join(stageDir, 'dist');
  mkdirSync(src, { recursive: true });
  copyFileSync(FIXTURE, join(src, 'host.spec'));
  for (const name of COMPONENT_SPECS) {
    copyFileSync(join(SPEC_REPO, 'packages', 'components', 'spec', name), join(src, name));
  }

  execFileSync(
    process.execPath,
    [join(SPEC_REPO, 'packages', 'cli', 'bin', 'spec.js'), 'compile', src, '--standalone', '--out', out],
    { cwd: stageDir, stdio: 'pipe' },
  );

  const bundle = readFileSync(join(out, 'bundle.js'), 'utf8');
  // Guard the harness assumption rather than trusting it: a bare specifier
  // here means the extern was not inlined and every drag test would fail
  // with a module-resolution error that looks like a component bug.
  const bare = bundle.match(/@spec\/components/g)?.length ?? 0;
  if (bare !== 0) {
    throw new Error(
      `standalone bundle still contains ${bare} bare @spec/components specifier(s) — ` +
        'switch this harness to `spec dev --registry ../spec-registry` + page.goto',
    );
  }
  if (!bundle.includes('wireColumnDrag')) {
    throw new Error('standalone bundle does not contain wireColumnDrag — the drag wire was not inlined');
  }

  bundleSrc =
    bundle +
    '\nwindow.__specMount = { mountReorderHost, mountGroupedReorderHost };\n';
});

test.afterAll(() => {
  if (stageDir) rmSync(stageDir, { recursive: true, force: true });
});

type MountName = 'mountReorderHost' | 'mountGroupedReorderHost';

declare global {
  interface Window {
    __specMount?: Record<MountName, (el: Element, props: unknown) => unknown>;
  }
}

async function mountHost(page: Page, surface: MountName) {
  await page.goto('about:blank');
  await page.setContent('<div id="host"></div>');
  await page.addScriptTag({ content: bundleSrc, type: 'module' });
  await page.waitForFunction(() => Boolean(window.__specMount));
  await page.evaluate((name) => {
    window.__specMount![name](document.getElementById('host')!, {});
  }, surface);
  await page.waitForSelector('[data-grid-id]');
  await page.waitForSelector('[data-grid-row="header"] [data-grid-col="d"]');

  // Wait for the drag wire to actually ATTACH, not just for the grid to
  // render. `wireColumnDrag` runs from a @state initialiser, before any DOM
  // exists, so it polls for its `[data-grid-id]` root on an 80ms timer — the
  // grid is fully rendered and interactive for roughly one frame BEFORE any
  // header cell is draggable. Dragging in that window does nothing at all and
  // reads exactly like a broken wire. `cursor: grab` is the attach's own
  // observable side effect, and asserting on it also proves the affordance
  // appears (which in turn proves the four columns resolved to ONE segment —
  // the wire refuses to make a size-1 segment draggable).
  await page.waitForFunction(() =>
    Array.from(document.querySelectorAll<HTMLElement>('[data-grid-row="header"] [data-grid-col]'))
      .every((el) => el.style.cursor === 'grab'),
  );
}

function headerKeys(page: Page): Promise<(string | null)[]> {
  return page.$$eval('[data-grid-row="header"] [data-grid-col]', (els) =>
    els.map((e) => e.getAttribute('data-grid-col')),
  );
}

/**
 * Drag column `from` onto column `to`.
 *
 * MANY small steps, never one jump. The wire's entry threshold counts a
 * column as passed only once the cursor is 20% into it FROM THE DIRECTION OF
 * TRAVEL, and direction is inferred by comparing each move's X with the
 * previous one — a single large move can resolve a stale direction and land
 * on the wrong gap. The steps also carry the pointer past `mouseMoveStart`
 * (5px) gradually, which is what separates a drag from a click.
 */
async function dragColumn(page: Page, from: string, to: string) {
  const src = page.locator(`[data-grid-row="header"] [data-grid-col="${from}"]`);
  const dst = page.locator(`[data-grid-row="header"] [data-grid-col="${to}"]`);
  const s = (await src.boundingBox())!;
  const d = (await dst.boundingBox())!;
  const startX = s.x + s.width / 2;
  const y = s.y + s.height / 2;
  const endX = d.x + d.width / 2;

  await page.mouse.move(startX, y);
  await page.mouse.down();
  const STEPS = 20;
  for (let i = 1; i <= STEPS; i++) {
    await page.mouse.move(startX + ((endX - startX) * i) / STEPS, y);
  }
  await page.mouse.up();
}

/** The header cell's sort indicator — '↑' asc, '↓' desc, '' unsorted. */
function sortIndicator(page: Page, key: string): Promise<string> {
  return page
    .locator(`[data-grid-row="header"] [data-grid-col="${key}"]`)
    .innerText()
    .then((t) => (t.includes('↑') ? '↑' : t.includes('↓') ? '↓' : ''));
}

test.describe('DataGridSpec column reorder', () => {
  test('dragging a column right reorders it and emits the new order', async ({ page }) => {
    await mountHost(page, 'mountReorderHost');
    expect(await headerKeys(page)).toEqual(['a', 'b', 'c', 'd']);

    await dragColumn(page, 'a', 'c');

    await expect(page.locator('[data-testid="emitted"]')).toHaveText('b,c,a,d');
    await expect.poll(() => headerKeys(page)).toEqual(['b', 'c', 'a', 'd']);
    // The drag must not also have sorted: pointerup on a header cell still
    // produces a native click, and the wire swallows it. Without that, every
    // reorder would silently re-sort the grid it just rearranged.
    expect(await sortIndicator(page, 'a')).toBe('');
  });

  test('dragging a column left reorders it', async ({ page }) => {
    await mountHost(page, 'mountReorderHost');

    await dragColumn(page, 'd', 'b');

    await expect(page.locator('[data-testid="emitted"]')).toHaveText('a,d,b,c');
    await expect.poll(() => headerKeys(page)).toEqual(['a', 'd', 'b', 'c']);
  });

  test('a click without movement sorts instead of dragging', async ({ page }) => {
    await mountHost(page, 'mountReorderHost');

    await page.locator('[data-grid-row="header"] [data-grid-col="a"]').click();

    // The header's own behaviour survived the wire...
    await expect.poll(() => sortIndicator(page, 'a')).toBe('↑');
    // ...and no drag happened: order unchanged, nothing emitted.
    expect(await headerKeys(page)).toEqual(['a', 'b', 'c', 'd']);
    await expect(page.locator('[data-testid="emitted"]')).toHaveText('');
  });

  test('escape cancels a drag in progress', async ({ page }) => {
    await mountHost(page, 'mountReorderHost');
    const s = (await page
      .locator('[data-grid-row="header"] [data-grid-col="a"]')
      .boundingBox())!;
    const startX = s.x + s.width / 2;
    const y = s.y + s.height / 2;

    await page.mouse.move(startX, y);
    await page.mouse.down();
    for (let i = 1; i <= 20; i++) await page.mouse.move(startX + (400 * i) / 20, y);

    // A drag really is under way before Escape — otherwise this test would
    // pass just as well against a wire that never started one.
    await expect(page.locator('[data-col-ghost]')).toHaveCount(1);
    await expect
      .poll(() => page.locator('[data-col-drop-slot]').evaluate((el) => el.style.opacity))
      .toBe('1');

    await page.keyboard.press('Escape');
    await page.mouse.up();

    await expect(page.locator('[data-col-ghost]')).toHaveCount(0);
    expect(await headerKeys(page)).toEqual(['a', 'b', 'c', 'd']);
    await expect(page.locator('[data-testid="emitted"]')).toHaveText('');
  });

  test('a grouped column cannot leave its group', async ({ page }) => {
    // Same four columns, but b and c share group "Q" — so they form segment
    // 's:Q' while a and d share 's:'. b may swap with c, never cross out.
    await mountHost(page, 'mountGroupedReorderHost');
    expect(await headerKeys(page)).toEqual(['a', 'b', 'c', 'd']);

    await dragColumn(page, 'b', 'd');

    // Assert the drag HAPPENED as well as where it stopped. The index
    // constraints below are satisfied by a grid that ignored the drag
    // entirely — this line is what separates "constrained" from "inert".
    await expect(page.locator('[data-testid="emitted"]')).toHaveText('a,c,b,d');

    const keys = await headerKeys(page);
    expect(keys.indexOf('b')).toBeGreaterThan(keys.indexOf('a'));
    expect(keys.indexOf('b')).toBeLessThan(keys.indexOf('d'));
  });
});
