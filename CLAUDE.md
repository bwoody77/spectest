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

## This project

- Admin dashboard demo with sidebar nav, dark mode, multiple theme presets
- `node dev.mjs` starts API server (port 4000) + dev server (port 3000)
- `server.mjs` provides mock REST APIs for tasks, stats, users, activity, notifications, products, categories

## Package manager

Use **pnpm** in the spec repo. Never use npm or yarn.

## After modifying the compiler

If you make changes to the Spec compiler, language, or runtime in `C:/projects/spec/`:
1. Rebuild: `cd C:/projects/spec && pnpm build`
2. Run tests: `pnpm test`
3. Consider whether docs need updating (see documentation protocol in `C:/projects/spec/CLAUDE.md`)
