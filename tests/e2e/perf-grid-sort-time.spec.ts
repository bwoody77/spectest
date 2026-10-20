/**
 * Grid 10K (perf-grid.spec): the SORT TIME card shows the time the native grid
 * measured (Vector #1309).
 *
 * DataGridNative calls `onSort(sortState, elapsed)`: two arguments, with the
 * elapsed time second. The page read `e.elapsed` off the first one (the
 * SortState array), so the card stayed "—" after every sort even though the
 * sort itself worked.
 *
 * The bulk endpoint returns random prices, so these tests serve their own
 * 10,000 rows with a known price permutation. That makes the Price ↑ order
 * exact. The second test pins performance.now() for the length of each header
 * click (the grid reads it exactly twice there, before and after sort + render),
 * so "the card shows the new time" cannot pass because two real timings happened
 * to round to the same tenth of a millisecond.
 */
import { test, expect, type Page } from '@playwright/test';

const COUNT = 10_000;

// 7919 is prime and coprime with 10,000, so k takes every value 0..9999 once:
// every price is distinct and the sorted order is known in advance.
const ROWS = Array.from({ length: COUNT }, (_, i) => {
  const k = (i * 7919 + 1234) % COUNT;
  return {
    id: i + 1,
    name: `Product ${i + 1}`,
    category: 'Audio',
    price: +(5 + k * 0.05).toFixed(2),
    stock: (i * 31) % 500,
    status: 'active',
    rating: 4,
    sku: `BLK-${String(i + 1).padStart(5, '0')}`,
  };
});
const IDS_BY_PRICE = [...ROWS].sort((a, b) => a.price - b.price).map((r) => r.id);

async function openGrid10K(page: Page) {
  await page.route('**/api/products/bulk*', (route) =>
    route.fulfill({
      status: 200,
      contentType: 'application/json',
      headers: { 'access-control-allow-origin': '*' },
      body: JSON.stringify(ROWS),
    }),
  );
  await page.goto('/');
  await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });
  await page.evaluate(() => {
    location.hash = 'perfgrid';
  });
  await expect(page.getByText(`${COUNT} rows`, { exact: true })).toBeVisible();
  await expect(page.locator('tr.spec-data-grid-row').first()).toBeVisible();
}

/** The value under the "Sort Time" caption. */
function sortTimeCard(page: Page) {
  return page
    .getByText('Sort Time', { exact: true })
    .locator('xpath=following-sibling::*[1]');
}

/** The ID column of every row the virtual window has rendered, top to bottom. */
function renderedIds(page: Page) {
  return page
    .locator('tr.spec-data-grid-row')
    .evaluateAll((trs) => trs.map((tr) => Number(tr.querySelector('td')?.textContent?.trim())));
}

/**
 * For the next click only, performance.now() returns 1000, 1000 + step, … one
 * step per read, so the grid measures exactly `step` ms for that sort.
 * Capture runs before the header's own listener and the bubble-phase listener
 * after it, so nothing outside the click sees the pinned clock.
 */
async function pinClockForNextClick(page: Page, step: number) {
  await page.evaluate((s) => {
    let reads = 0;
    document.addEventListener(
      'click',
      () => {
        performance.now = () => 1000 + s * reads++;
      },
      { capture: true, once: true },
    );
    document.addEventListener(
      'click',
      () => {
        delete (performance as { now?: unknown }).now;
      },
      { once: true },
    );
  }, step);
}

test.describe('Grid 10K — Sort Time card', () => {
  test('sorting by Price ascending shows a time and reorders all 10,000 rows', async ({ page }) => {
    await openGrid10K(page);
    await expect(sortTimeCard(page)).toHaveText('—');

    await page.locator('th[data-key="price"]').click();

    await expect(page.locator('th[data-key="price"]')).toContainText('↑');
    await expect(sortTimeCard(page)).toHaveText(/^\d+\.\d ms$/);

    // Top of the list: the cheapest rows, in order.
    const top = await renderedIds(page);
    expect(top.length).toBeGreaterThan(5);
    expect(top).toEqual(IDS_BY_PRICE.slice(0, top.length));

    // Bottom of the list: the dearest rows, in order, ending at row 10,000.
    await page.locator('.spec-data-grid-scroll').evaluate((el) => {
      el.scrollTop = el.scrollHeight;
    });
    await expect(page.locator('tr.spec-data-grid-row').last()).toHaveAttribute(
      'aria-rowindex',
      String(COUNT),
    );
    const bottom = await renderedIds(page);
    expect(bottom).toEqual(IDS_BY_PRICE.slice(COUNT - bottom.length));
  });

  test('a second sort, by another column, replaces the time with the new one', async ({ page }) => {
    await openGrid10K(page);

    await pinClockForNextClick(page, 12.5);
    await page.locator('th[data-key="price"]').click();
    await expect(sortTimeCard(page)).toHaveText('12.5 ms');

    await pinClockForNextClick(page, 37.5);
    await page.locator('th[data-key="stock"]').click();
    await expect(page.locator('th[data-key="stock"]')).toContainText('↑');
    await expect(sortTimeCard(page)).toHaveText('37.5 ms');
  });
});
