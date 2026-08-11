/**
 * ColumnChooser + group drag — real-layout tests (One Grid P3).
 *
 * ── Why this file exists ────────────────────────────────────────────────────
 * The component suite runs in happy-dom, which computes NO geometry:
 * `getBoundingClientRect()` returns all zeros there. Everything this file
 * asserts is therefore invisible to that suite —
 *
 *   · the drop SLOT's height (the whole point of the affordance: a slot the
 *     size of what you are carrying, not a 2px line the ghost covers up),
 *   · a group travelling as a block,
 *   · and the P1 order contract, which only misbehaves once a real drag runs.
 *
 * ── Harness ─────────────────────────────────────────────────────────────────
 * Identical to grid-column-reorder.spec.ts: the fixture surface plus the
 * component sources it uses are staged outside both repos and compiled as one
 * `--standalone` project, then injected with `addScriptTag`. Nothing resolves
 * from `.spec-packages/`, a cache that has silently tested a version four minor
 * releases old.
 *
 * Point SPEC_REPO at a worktree to test unmerged component work:
 *
 *     SPEC_REPO=C:/projects/spec-worktrees/p3-column-chooser npx playwright \
 *       test tests/e2e/column-chooser.spec.ts
 *
 * ⚠ Always name the file. A bare `npx playwright test` is broken on spectest
 * main — bundleStandalone cannot resolve app.spec's relative externs.
 */

import { test, expect, type Page } from '@playwright/test';
import { execFileSync } from 'node:child_process';
import { mkdtempSync, mkdirSync, copyFileSync, readFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = dirname(fileURLToPath(import.meta.url));
const FIXTURE = join(HERE, '..', '..', 'fixtures', 'column-chooser', 'host.spec');
const SPEC_REPO = (process.env.SPEC_REPO ?? 'C:/projects/spec').replace(/\\/g, '/');

/** Component sources the fixture needs, compiled from source alongside it. */
const COMPONENT_SPECS = [
  'data-grid-spec.spec',
  'checkbox.spec',
  'column-chooser.spec',
  'popover.spec',
  'button.spec',
];

let bundleSrc = '';
let stageDir = '';

test.beforeAll(() => {
  stageDir = mkdtempSync(join(tmpdir(), 'spec-column-chooser-'));
  const src = join(stageDir, 'src');
  const out = join(stageDir, 'dist');
  mkdirSync(src, { recursive: true });
  copyFileSync(FIXTURE, join(src, 'host.spec'));
  for (const name of COMPONENT_SPECS) {
    copyFileSync(join(SPEC_REPO, 'packages', 'components', 'spec', name), join(src, name));
  }

  execFileSync(
    process.execPath,
    [
      join(SPEC_REPO, 'packages', 'cli', 'bin', 'spec.js'),
      'compile',
      src,
      '--standalone',
      '--out',
      out,
    ],
    { cwd: stageDir, stdio: 'pipe' },
  );

  const bundle = readFileSync(join(out, 'bundle.js'), 'utf8');
  // Guard the harness assumptions rather than trusting them: a bare specifier
  // means an extern was not inlined, and a missing wire name means the drag
  // code never made it into the bundle — both fail as what looks like a
  // component bug several tests later.
  const bare = bundle.match(/@spec\/components/g)?.length ?? 0;
  if (bare !== 0) {
    throw new Error(
      `standalone bundle still contains ${bare} bare @spec/components specifier(s)`,
    );
  }
  for (const name of ['wireChooserDrag', 'wireGroupDrag', 'mergeHiddenKeys']) {
    if (!bundle.includes(name)) {
      throw new Error(`standalone bundle does not contain ${name} — it was not inlined`);
    }
  }

  bundleSrc = bundle + '\nwindow.__specMount = { mountChooserHost };\n';
});

test.afterAll(() => {
  if (stageDir) rmSync(stageDir, { recursive: true, force: true });
});

declare global {
  interface Window {
    __specMount?: Record<string, (el: Element, props: unknown) => unknown>;
  }
}

async function mountHost(page: Page) {
  await page.goto('about:blank');
  await page.setContent('<div id="host"></div>');
  await page.addScriptTag({ content: bundleSrc, type: 'module' });
  await page.waitForFunction(() => Boolean(window.__specMount));
  await page.evaluate(() => {
    window.__specMount!.mountChooserHost(document.getElementById('host')!, {});
  });
  await page.waitForSelector('[data-grid-id]');
}

/**
 * Open the chooser and wait for its drag wire to ATTACH.
 *
 * Not for the panel to be visible — the wire polls for its list on an 80 ms
 * timer, so the rows are on screen and interactive for roughly one frame
 * before any grip works. A test that asserts in that window passes against a
 * completely broken wire; this has happened here before. `cursor: grab` is the
 * attach's own observable side effect, so it is what we wait on.
 */
async function openChooser(page: Page) {
  await page.locator('[data-colchooser-trigger]').click();
  await page.waitForSelector('[data-colchooser-list]');
  await page.waitForFunction(() => {
    const grips = Array.from(
      document.querySelectorAll<HTMLElement>('[data-colchooser-grip]'),
    ).filter((el) => el.offsetParent !== null);
    return grips.length > 0 && grips.every((el) => getComputedStyle(el).cursor === 'grab');
  });
}

function headerKeys(page: Page): Promise<(string | null)[]> {
  return page.$$eval('[data-grid-row="header"] [data-grid-col]', (els) =>
    els.map((e) => e.getAttribute('data-grid-col')),
  );
}

function chooserKeys(page: Page): Promise<(string | null)[]> {
  return page.$$eval('[data-colchooser-key]', (els) =>
    els.map((e) => e.getAttribute('data-colchooser-key')),
  );
}

/**
 * Press on a grip and move in small steps WITHOUT releasing.
 *
 * Many small steps, never one jump: the pointer has to cross `mouseMoveStart`
 * (5px) gradually for a drag to be distinguished from a click, and drag-core
 * hit-tests each move.
 */
async function pressAndMove(page: Page, gripSelector: string, toSelector: string) {
  const src = page.locator(gripSelector).first();
  const dst = page.locator(toSelector).first();
  const s = (await src.boundingBox())!;
  const d = (await dst.boundingBox())!;
  const startX = s.x + s.width / 2;
  const startY = s.y + s.height / 2;
  const endX = d.x + d.width / 2;
  const endY = d.y + d.height / 2;

  await page.mouse.move(startX, startY);
  await page.mouse.down();
  const STEPS = 16;
  for (let i = 1; i <= STEPS; i++) {
    await page.mouse.move(
      startX + ((endX - startX) * i) / STEPS,
      startY + ((endY - startY) * i) / STEPS,
    );
  }
}

test.describe('ColumnChooser drop affordance', () => {
  test('the drop slot is as tall as the column being carried', async ({ page }) => {
    await mountHost(page);
    await openChooser(page);

    const rowHeight = (await page
      .locator('[data-colchooser-key="a"]')
      .boundingBox())!.height;
    expect(rowHeight).toBeGreaterThan(0);

    await pressAndMove(page, '[data-colchooser-key="a"] [data-colchooser-grip]', '[data-colchooser-key="z"]');

    const slot = page.locator('[data-colchooser-slot]');
    await expect(slot).toBeVisible();
    const slotBox = (await slot.boundingBox())!;
    // The whole point of the affordance: a space the size of what is being
    // dropped. A 2px insertion line sits underneath the ghost, so the one
    // thing the user needs to see is the one thing covered up.
    expect(Math.abs(slotBox.height - rowHeight)).toBeLessThanOrEqual(1);

    // …and the source has left the flow, so the slot is the only gap.
    const srcDisplay = await page.$eval(
      '[data-colchooser-key="a"]',
      (el) => (el as HTMLElement).style.display,
    );
    expect(srcDisplay).toBe('none');

    await page.mouse.up();
  });

  test('the drop slot is as tall as the whole group being carried', async ({ page }) => {
    await mountHost(page);
    await openChooser(page);

    const boxes = await page.evaluate(() => {
      const sel = [
        '[data-colchooser-group="Q"]',
        '[data-colchooser-key="g1"]',
        '[data-colchooser-key="g2"]',
      ];
      return sel.map((s) => document.querySelector(s)!.getBoundingClientRect().height);
    });
    const blockHeight = boxes.reduce((a, b) => a + b, 0);
    expect(blockHeight).toBeGreaterThan(0);

    await pressAndMove(
      page,
      '[data-colchooser-group="Q"] [data-colchooser-group-grip]',
      '[data-colchooser-key="a"]',
    );

    const slotBox = (await page.locator('[data-colchooser-slot]').boundingBox())!;
    // Five rows' worth for cf-market's Quality; three here. The claim is that
    // the slot matches the BLOCK, not one row of it.
    expect(Math.abs(slotBox.height - blockHeight)).toBeLessThanOrEqual(1);

    await page.mouse.up();
  });
});

test.describe('a group moves as a unit', () => {
  test('dragging the group row in the chooser carries every member', async ({ page }) => {
    await mountHost(page);
    await openChooser(page);
    expect(await chooserKeys(page)).toEqual(['a', 'b', 'c', 'g1', 'g2', 'z']);

    await pressAndMove(
      page,
      '[data-colchooser-group="Q"] [data-colchooser-group-grip]',
      '[data-colchooser-key="a"]',
    );
    await page.mouse.up();

    // Both members travelled, in their existing internal order, and the
    // ungrouped columns kept theirs.
    await expect.poll(() => chooserKeys(page)).toEqual(['g1', 'g2', 'a', 'b', 'c', 'z']);
    await expect(page.locator('[data-testid="emitted"]')).toHaveText('g1,g2,a,b,c,z');
  });

  test('dragging the group label in the grid header carries every member', async ({ page }) => {
    await mountHost(page);
    // `c` is hidden, so the header shows a, b, [g1 g2], z.
    expect(await headerKeys(page)).toEqual(['a', 'b', 'g1', 'g2', 'z']);

    // Wait for the GROUP wire specifically — its own attach side effect.
    await page.waitForFunction(() => {
      const el = document.querySelector<HTMLElement>('[data-grid-seg-label]');
      return Boolean(el) && getComputedStyle(el!).cursor === 'grab';
    });

    const label = page.locator('[data-grid-seg-label]');
    const dst = page.locator('[data-grid-row="header"] [data-grid-col="a"]');
    const s = (await label.boundingBox())!;
    const d = (await dst.boundingBox())!;
    const y = s.y + s.height / 2;
    const startX = s.x + s.width / 2;
    const endX = d.x + d.width / 2;
    await page.mouse.move(startX, y);
    await page.mouse.down();
    for (let i = 1; i <= 20; i++) {
      await page.mouse.move(startX + ((endX - startX) * i) / 20, y);
    }
    await page.mouse.up();

    await expect.poll(() => headerKeys(page)).toEqual(['g1', 'g2', 'a', 'b', 'z']);
  });
});

test.describe('the emitted order carries hidden columns', () => {
  test('a header drag retains a hidden key in its saved position', async ({ page }) => {
    await mountHost(page);
    // `c` is hidden from the start and sits between `b` and the group.
    expect(await headerKeys(page)).toEqual(['a', 'b', 'g1', 'g2', 'z']);

    // Wait for THE CELL WE ARE ABOUT TO DRAG, not for any armed cell. `some()`
    // went green as soon as the first cell was armed and the drag then landed
    // in the window before `a` had its listener — a one-in-two flake that looks
    // exactly like a broken emit.
    await page.waitForFunction(() => {
      const el = document.querySelector<HTMLElement>(
        '[data-grid-row="header"] [data-grid-col="a"]',
      );
      return Boolean(el) && el!.style.cursor === 'grab';
    });

    const src = page.locator('[data-grid-row="header"] [data-grid-col="a"]');
    const dst = page.locator('[data-grid-row="header"] [data-grid-col="b"]');
    const s = (await src.boundingBox())!;
    const d = (await dst.boundingBox())!;
    const y = s.y + s.height / 2;
    const startX = s.x + s.width / 2;
    // Past b's RIGHT EDGE, not its centre. `a` and `b` are the whole segment,
    // so a centre-to-centre move sits right on the wire's 20%-entry threshold
    // and whether it resolves depends on which sample crosses first — a coin
    // flip that reads as a broken emit. Overshooting is unambiguous, and the
    // gap index is clamped to the segment either way.
    const endX = d.x + d.width - 4;
    await page.mouse.move(startX, y);
    await page.mouse.down();
    for (let i = 1; i <= 24; i++) {
      await page.mouse.move(startX + ((endX - startX) * i) / 24, y);
    }
    await page.mouse.up();

    // THE P3 REGRESSION GUARD. The wire can only see a, b, g1, g2, z — emitting
    // that verbatim drops `c` silently, and showing it again would append it at
    // the end, throwing away where the user had put it. `c` must still be in
    // the payload, anchored after `b`, which is what it followed.
    // `toHaveText` RETRIES; a bare innerText() does not. The emit reaches the
    // testid through a Spec state update and a re-render, so reading once
    // immediately after mouseup sampled an empty node about half the time —
    // which reads exactly like "the grid never emitted".
    await expect(page.locator('[data-testid="emitted"]')).toHaveText('b,c,a,g1,g2,z');
    const emitted = await page.locator('[data-testid="emitted"]').innerText();
    expect(emitted.split(',')).toContain('c');
  });
});
