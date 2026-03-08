import { test, expect } from './fixtures';

test.describe('Bytecode boot', () => {
  test('app loads with "Spec Admin" header and no console errors', async ({
    page,
    consoleErrors,
  }) => {
    await page.goto('/');
    await page.waitForTimeout(2000);

    // The app header should be visible
    await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });

    // No console errors during boot
    expect(consoleErrors.errors).toEqual([]);
  });

  test('bundle.specbc is served with 200', async ({ request }) => {
    const res = await request.get('/bundle.specbc');
    expect(res.status()).toBe(200);
  });

  test('API server is running', async ({ request }) => {
    const res = await request.get('http://localhost:4000/api/stats');
    expect(res.status()).toBe(200);
    const data = await res.json();
    expect(data).toHaveProperty('total');
  });
});
