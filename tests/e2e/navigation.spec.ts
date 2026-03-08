import { test, expect, VIEWS, isKnownError } from './fixtures';

test.describe('Navigation — all views mount without errors', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForTimeout(2000);
    // Ensure the app is loaded before navigating
    await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });
  });

  for (const view of VIEWS) {
    test(`view: ${view}`, async ({ page, consoleErrors, navigateTo }) => {
      await navigateTo(view);

      // The page should still have content (not a blank crash)
      const body = page.locator('body');
      await expect(body).not.toBeEmpty();

      // Zero console errors after navigating to this view
      const errors = consoleErrors.errors.filter(
        (e) =>
          !e.includes('Failed to fetch') &&
          !e.includes('NetworkError') &&
          !isKnownError(e)
      );
      expect(errors).toEqual([]);
    });
  }
});
