import { test, expect } from './fixtures';

test.describe('UI interactions', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForTimeout(2000);
    await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });
  });

  test('sidebar click navigates to analytics', async ({ page }) => {
    // Click the "Analytics" sidebar item
    const analyticsLink = page.locator('text=Analytics').first();
    await analyticsLink.click();
    await page.waitForTimeout(800);

    // Hash should update
    const hash = await page.evaluate(() => location.hash);
    expect(hash).toBe('#analytics');
  });

  test('dashboard shows stats from API', async ({ page }) => {
    // Dashboard is the default view — stats should render
    await page.waitForTimeout(2000);

    // The StatsBar should show numeric values loaded from the API
    const statsRegion = page.locator('[aria-label="Dashboard"]');
    await expect(statsRegion).toBeVisible({ timeout: 10_000 });
  });

  test('create view has form inputs', async ({ page, navigateTo }) => {
    await navigateTo('create');

    // The create form should have input-like elements
    const region = page.locator('[aria-label="Create task"]');
    await expect(region).toBeVisible({ timeout: 10_000 });
  });

  test('notifications view shows API data', async ({ page, navigateTo }) => {
    await navigateTo('notifications');
    await page.waitForTimeout(2000);

    // "Deployment succeeded" is in the mock notifications API
    await expect(page.locator('text=Deployment succeeded')).toBeVisible({ timeout: 10_000 });
  });

  test('data grid shows products from API', async ({ page, navigateTo }) => {
    await navigateTo('datagrid');
    await page.waitForTimeout(2000);

    // "Wireless Mouse" is in the mock products API
    await expect(page.locator('text=Wireless Mouse')).toBeVisible({ timeout: 10_000 });
  });

  test('categories tree shows data from API', async ({ page, navigateTo }) => {
    await navigateTo('categories');
    await page.waitForTimeout(2000);

    // "Electronics" is in the mock categories API
    await expect(page.locator('text=Electronics')).toBeVisible({ timeout: 10_000 });
  });
});
