# Spectest — Demo App for the Spec Language

This is a demo/test project for the Spec language. The Spec compiler and language source lives at `C:/projects/spec/`.

## Before starting any work

Read the relevant reference docs from the main repo:

| Document | When to read | Path |
|----------|-------------|------|
| `docs/ai-reference.md` | Writing or editing `.spec` files | `C:/projects/spec/docs/ai-reference.md` |
| `docs/compiler-dev-principles.md` | Before any compiler/language/runtime change | `C:/projects/spec/docs/compiler-dev-principles.md` |
| `docs/compiler-contributor-guide.md` | Navigating the compiler codebase, finding files | `C:/projects/spec/docs/compiler-contributor-guide.md` |
| `CLAUDE.md` | Project conventions, build commands, package structure | `C:/projects/spec/CLAUDE.md` |
| `docs/component-testing.md` | Writing component tests with mountForTest() | `C:/projects/spec/docs/component-testing.md` |
| `docs/fn-reference.md` | Writing pure functions (`fn`) — stdlib, pipes, types | `C:/projects/spec/docs/fn-reference.md` |
| `docs/layouts.md` | Using layout packages from the spec-registry | `C:/projects/spec/docs/layouts.md` |

## This project

- Admin dashboard demo with sidebar nav, dark mode, multiple theme presets
- `node dev.mjs` starts API server (port 4500) + dev server (port 3000). Override with `--api-port=<n>` (or `--api-port <n>`) / `SPECTEST_API_PORT` and `--port=<n>` / `SPECTEST_PORT`. The `.spec` sources keep naming `localhost:4500`; on another API port the web page reroutes those calls before it mounts (`src/api-origin.mjs`, installed by `src/boot.mjs` in dev and by dev.mjs's prod shell), so never change the `endpoint:` lines for a port. The iOS views still call 4500. It never kills a process it did not start: a busy port is refused and left alone (port 4000 is Vector's dev slot 0, which an older dev.mjs used to kill)
- `server.mjs` provides mock REST APIs for tasks, stats, users, activity, notifications, products, categories

## Package manager

Use **pnpm** in the spec repo. Never use npm or yarn.

## After modifying the compiler

If you make changes to the Spec compiler, language, or runtime in `C:/projects/spec/`:
1. Rebuild: `cd C:/projects/spec && pnpm build`
2. Run tests: `pnpm test`
3. Consider whether docs need updating (see documentation protocol in `C:/projects/spec/CLAUDE.md`)

## Knowledge system

Structured knowledge and cross-project reference docs are available:

- **Cross-project hub**: read `../.knowledge/_root.md` for pipeline docs, project registry, conventions
- **Search**: `node ../.knowledge/bin/knowledge.js search "<query>"` (auto-syncs stale index)
