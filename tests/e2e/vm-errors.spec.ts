import { test, expect, VIEWS, isKnownError } from './fixtures';

test.describe('VM error sweep', () => {
  test('no "Unknown opcode" errors across all views', async ({
    page,
    consoleErrors,
    navigateTo,
  }) => {
    await page.goto('/');
    await page.waitForTimeout(2000);
    await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });

    // Rapidly navigate through every view
    for (const view of VIEWS) {
      await navigateTo(view);
    }

    // Check for the specific error pattern that the 0x68 bug produced
    const opcodeErrors = consoleErrors.errors.filter((e) =>
      e.includes('Unknown opcode')
    );
    expect(opcodeErrors).toEqual([]);
  });

  test('no uncaught exceptions across all views', async ({
    page,
    consoleErrors,
    navigateTo,
  }) => {
    await page.goto('/');
    await page.waitForTimeout(2000);
    await expect(page.locator('text=Spec Admin')).toBeVisible({ timeout: 15_000 });

    for (const view of VIEWS) {
      await navigateTo(view);
    }

    // Filter out benign network errors and known issues — care about new runtime crashes
    const realErrors = consoleErrors.errors.filter(
      (e) =>
        !e.includes('Failed to fetch') &&
        !e.includes('NetworkError') &&
        !e.includes('net::ERR') &&
        !isKnownError(e)
    );
    expect(realErrors).toEqual([]);
  });
});
