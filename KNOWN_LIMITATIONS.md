# Known Limitations

Documented limitations of the spec language and runtime that affect this test app.

## ~~Async Actions~~ (Resolved)

`@actions` now support `await`. The compiler detects async usage and emits
`async` function wrappers automatically. `await fetch(...)` works in actions
and `@watch` blocks.

## ~~State Persistence~~ (Resolved)

`@persist` annotation is implemented. State fields annotated with `@persist`
are stored in localStorage with cross-tab sync. This app uses it for
`themePreset: "default" @persist`.

`@route` syncs state to the URL hash. `@undoable` provides undo/redo with
automatic history tracking.

## Source Refetch

The runtime has an `invalidate()` method on source results that clears the
cache so the next fetch goes to the network. However, there is **no language-level
syntax** to call `invalidate()` or `refetch()` from an `@actions` block.

**Impact:** After creating or deleting a task via `fetch()`, the task list source
does not refetch. The user must refresh the page to see updated data.

**Workaround:** Parameterized sources auto-refetch when their parameter signal
changes, but this doesn't help for imperative mutation-then-refetch flows.

**Future:** Language syntax for `source.invalidate()` or `source.refetch()` in actions.

## Source Maps

The source map builder (`SourceMapBuilder` with V3/VLQ support) exists in the
compiler but is **not wired into codegen**. `ir-to-js.ts` never calls it.
The `--source-maps` CLI flag is accepted but produces no output.

**Impact:** No mapping from generated JS back to `.spec` source in browser devtools.

## SSR / SSG

No server-side rendering or static site generation. The runtime is purely
client-side DOM manipulation.

**Impact:** No SEO support, no pre-rendered HTML, full JS required for first paint.

## Hot Reload

The dev server uses full page reload via SSE, not true Hot Module Replacement.
All client state is lost on every file change.

**Impact:** Theme selection, form inputs, scroll position, and navigation state
reset on each save during development.
