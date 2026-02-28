# Known Limitations — Gate #16

Documented limitations of the spec language and runtime that affect this test app.
These are language/runtime features for future issues, not Gate #16 blockers.

## Async Actions

`@actions` compile to synchronous JavaScript. `fetch()` calls within actions are
fire-and-forget — the returned Promise is discarded with no `.then()` or `await`.

**Impact:** `submitForm()` in TaskForm and `confirmDelete()` in TaskDetail fire
network requests but cannot report success/failure back into signal state. The
`submitting` flag is set before `fetch()` and reset immediately after (optimistic),
not after the request completes.

**Future:** Async action support (`await` in `@actions`, or `.then()` on fetch results).

## State Persistence

`@state` is in-memory only. All state — form fields, wizard progress, filter
selections, overlay open/closed — resets on page refresh. `@route` covers hash-based
view routing only (e.g. `view: "dashboard" @route`).

**Impact:** The wizard (WizardStep1–3) loses all entered data on refresh. TaskTable
filter selections reset. TaskForm field contents reset.

**Future:** `@persist` annotation or similar mechanism for durable state.

## Source Refetch

`@source` exposes `loading`, `error`, and `data` signals automatically, but does
not expose `invalidate()` or manual refetch to the surface. Data is fetched once
on mount (with optional cache TTL and retry).

**Impact:** After creating or deleting a task via `fetch()`, the TaskTable source
does not refetch. The user must refresh the page to see updated data.

**Future:** Imperative source actions (`source.invalidate()`, `source.refetch()`).
