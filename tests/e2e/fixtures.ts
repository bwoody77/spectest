import { test as base, expect, type Page } from '@playwright/test';

/** All active view hash-routes in the app. */
export const VIEWS = [
  'dashboard',
  'analytics',
  'detail',
  'create',
  'wizard',
  'datagrid',
  'editgrid',
  'categories',
  'team',
  'activity',
  'notifications',
  'settings',
  'reactivityperf',
  'themepreview',
  'charts',
  'drag',
  'formdemo',
  'routing',
  'mobiledemo',
  'featuretest',
] as const;

export type ViewId = (typeof VIEWS)[number];

/** Views that fetch from the API server and may need extra settle time. */
export const API_VIEWS = new Set<string>([
  'dashboard',
  'analytics',
  'detail',
  'datagrid',
  'editgrid',
  'categories',
  'team',
  'activity',
  'notifications',
]);

/**
 * Known pre-existing runtime errors in bytecode mode.
 * These are real bugs that should be fixed, but we don't want them
 * to block the entire test suite. Remove entries as bugs are fixed.
 */
export const KNOWN_ERRORS = [
  'semantic is not defined', // mobiledemo surface — bytecode codegen bug
];

/** Returns true if the error message matches a known pre-existing issue. */
export function isKnownError(msg: string): boolean {
  return KNOWN_ERRORS.some((known) => msg.includes(known));
}

type ConsoleCollector = { errors: string[]; warnings: string[] };

/**
 * Extended test fixture that collects console errors and page crashes.
 */
export const test = base.extend<{
  consoleErrors: ConsoleCollector;
  navigateTo: (view: ViewId) => Promise<void>;
}>({
  consoleErrors: async ({ page }, use) => {
    const collector: ConsoleCollector = { errors: [], warnings: [] };

    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        collector.errors.push(msg.text());
      }
    });

    page.on('pageerror', (err) => {
      collector.errors.push(err.message);
    });

    await use(collector);
  },

  navigateTo: async ({ page }, use) => {
    const navigate = async (view: ViewId) => {
      await page.evaluate((v) => {
        location.hash = v;
      }, view);
      // Wait for the VM / runtime to settle
      await page.waitForTimeout(API_VIEWS.has(view) ? 1500 : 600);
    };
    await use(navigate);
  },
});

export { expect };
