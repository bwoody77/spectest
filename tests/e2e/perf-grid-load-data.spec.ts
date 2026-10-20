/**
 * Grid 10K (perf-grid.spec): Load Data loads the rows and fills the LOAD TIME
 * card (Vector #1377).
 *
 * The compiler rewrites `fetch(...)` in an action to the runtime's
 * `__specFetch`, which answers the PARSED body, not a Response. The page
 * chained `.then(r => r.json())` onto it, so `r` was the 10,000-row array and
 * every click threw "Ne.json is not a function" (Ne being the minified name):
 * the rows never replaced the mount-time data and the card stayed "—".
 *
 * The mount-time @source and Load Data hit the same endpoint; Load Data's
 * request carries `delay=0`. These tests answer each with differently named
 * rows, so "the grid shows the loaded rows" cannot pass on the source's data.
 * performance.now() is held still for each load and moved forward by a known
 * step while the request is in flight, so the card must show exactly that
 * step: two real timings could round to the same millisecond and pass a
 * second click that never updated it.
 */
import { test, expect, type Page } from '@playwright/test';

const COUNT = 10_000;

function rows(prefix: string, count: number) {
  return Array.from({ length: count }, (_, i) => ({
    id: i + 1,
    name: `${prefix} ${i + 1}`,
    category: 'Audio',
    price: 10,
    stock: i % 500,
    status: 'active',
    rating: 4,
    sku: `BLK-${String(i + 1).padStart(5, '0')}`,
  }));
}

interface LoadServer {
  /** Load Data requests answered so far. */
  loads: number;
  /** Milliseconds to move the page's clock forward before answering the next load. */
  advanceMs: number;
}

/**
 * Serves the bulk endpoint: the mount-time @source gets "Source N" rows and
 * the Nth Load Data click gets "Load N row M" rows, `count` of them.
 */
async function serveBulk(page: Page): Promise<LoadServer> {
  const server: LoadServer = { loads: 0, advanceMs: 0 };
  await page.route('**/api/products/bulk*', async (route) => {
    const url = new URL(route.request().url());
    const count = Number(url.searchParams.get('count') ?? COUNT);
    let body;
    if (url.searchParams.get('delay') === '0') {
      server.loads += 1;
      if (server.advanceMs > 0) {
        await page.evaluate((ms) => {
          (window as unknown as { __loadClock: number }).__loadClock += ms;
        }, server.advanceMs);
      }
      body = rows(`Load ${server.loads} row`, count);
    } else {
      body = rows('Source', count);
    }
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      headers: { 'access-control-allow-origin': '*' },
      body: JSON.stringify(body),
    });
  });
  return server;
}

/** Every uncaught error and console error the page reports from now on. */
function collectErrors(page: Page): string[] {
  const errors: string[] = [];
  page.on('pageerror', (err) => errors.push(`pageerror: ${err.message}`));
  page.on('console', (msg) => {
    if (msg.type() === 'error') errors.push(`console: ${msg.text()}`);
  });
  return errors;
}

async function openGrid10K(page: Page) {
  await page.goto('/');
  await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });
  await page.evaluate(() => {
    location.hash = 'perfgrid';
  });
  await expect(page.getByText(`${COUNT} rows`, { exact: true })).toBeVisible();
  await expect(firstRowName(page)).toHaveText('Source 1');
}

/** The value under the "Load Time" caption. */
function loadTimeCard(page: Page) {
  return page
    .getByText('Load Time', { exact: true })
    .locator('xpath=following-sibling::*[1]');
}

/** The Product Name cell of the grid's first rendered row. */
function firstRowName(page: Page) {
  return page.locator('tr.spec-data-grid-row').first().locator('td').nth(1);
}

/**
 * Clicks Load Data with performance.now() held at `startMs`; the server moves
 * it forward by `elapsedMs` before answering, so the page measures exactly
 * `elapsedMs`. The real clock comes back once the card shows it.
 */
async function loadData(page: Page, server: LoadServer, startMs: number, elapsedMs: number) {
  await page.evaluate((t) => {
    const w = window as unknown as { __loadClock: number };
    w.__loadClock = t;
    performance.now = () => w.__loadClock;
  }, startMs);
  server.advanceMs = elapsedMs;
  await page.getByRole('button', { name: 'Load Data' }).click();
  await expect(loadTimeCard(page)).toHaveText(`${elapsedMs} ms`);
  await page.evaluate(() => {
    delete (performance as { now?: unknown }).now;
  });
}

test.describe('Grid 10K — Load Data', () => {
  test('loads 10,000 rows into the grid and shows the load time, with no error', async ({ page }) => {
    const errors = collectErrors(page);
    const server = await serveBulk(page);
    await openGrid10K(page);
    await expect(loadTimeCard(page)).toHaveText('—');

    await loadData(page, server, 1000, 250);

    expect(server.loads).toBe(1);
    await expect(page.getByText(`${COUNT} rows`, { exact: true })).toBeVisible();
    await expect(firstRowName(page)).toHaveText('Load 1 row 1');

    // The last row is the 10,000th loaded row, not the source's.
    await page.locator('.spec-data-grid-scroll').evaluate((el) => {
      el.scrollTop = el.scrollHeight;
    });
    const last = page.locator('tr.spec-data-grid-row').last();
    await expect(last).toHaveAttribute('aria-rowindex', String(COUNT));
    await expect(last.locator('td').nth(1)).toHaveText(`Load 1 row ${COUNT}`);

    expect(errors).toEqual([]);
  });

  test('a second Load Data replaces the rows and the time with the new ones', async ({ page }) => {
    const errors = collectErrors(page);
    const server = await serveBulk(page);
    await openGrid10K(page);

    await loadData(page, server, 1000, 250);
    await expect(firstRowName(page)).toHaveText('Load 1 row 1');

    await loadData(page, server, 5000, 730);
    expect(server.loads).toBe(2);
    await expect(firstRowName(page)).toHaveText('Load 2 row 1');
    await expect(page.getByText(`${COUNT} rows`, { exact: true })).toBeVisible();

    expect(errors).toEqual([]);
  });
});
