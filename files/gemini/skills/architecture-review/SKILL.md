---
name: architecture-review
description: >-
  Identify low-leverage modules and guide FP-idiomatic architectural
  refactoring. Conducts multi-stage exploration, interface design,
  backward-compatible migration planning, and TDD implementation.
---

Guide architectural refactoring to increase module leverage, composability,
and testability using pure functional programming patterns.

## Operating Mode

Read-only until the user selects a candidate module (Step 2).

- Do not edit files, create tests, or run mutating commands during
  exploration.
- After candidate selection, design alternative interfaces (Step 3),
  stress-test with `requirements-review` (Step 4), plan migration (Step 5),
  and execute via TDD (Step 6).

## Multi-Stage Process

### 1. Explore Codebase

Inspect `GLOSSARY.md` and `docs/REQ-*` for domain context. Walk the codebase
using `grep_search` and `list_dir` to measure architectural friction:

- **High Fan-in / Fan-out:** Modules coupled across many disparate contexts.
- **Low Leverage:** Modules where interface complexity equals internal logic.
- **Lost Locality:** Helpers extracted solely for unit tests, while caller
  orchestration logic harbours defects.
- **Leaky Boundaries:** Modules exposing internal representations.
- **Deletion Test:** Would removing the module concentrate complexity
  locally or scatter it across callers?

### 2. Present Candidates

List refactoring candidates with:

- **Files:** Target modules and dependents.
- **Problem:** Architectural friction and metric evidence.
- **Solution:** Plain-English FP pattern
  (see [docs/fp-patterns.md](docs/fp-patterns.md)).
- **Benefits:** Expected gains in leverage, locality, and testability.

*Do not propose concrete code interfaces yet. Prompt the user to choose a
candidate.*

### 3. Design the Interface

Follow [docs/interface-design.md](docs/interface-design.md). Design at least
three distinctly different interface contracts before recommending one.

### 4. Grilling Loop

Stress-test the chosen interface using the `requirements-review` skill.
Update `GLOSSARY.md` lazily and propose decision notes in
`docs/REQ-NNN-slug.md` for load-bearing trade-offs.

### 5. Plan Migration Strategy

Outline a backward-compatible migration plan (e.g. Strangler Fig pattern)
ensuring callers can transition incrementally without breaking builds.

### 6. Test-Driven Implementation (TDD)

Follow [docs/tdd.md](docs/tdd.md):

1. **Red:** Write failing tests against the new contract.
2. **Green:** Minimal pure implementation to pass.
3. **Refactor:** Clean implementation while preserving green tests.

### 7. Build and Verify

- Execute test and build suites (`make`, `cabal test`, `pytest`, `cargo test`).
- Perform dead-code cleanup of deprecated modules.
- Validate documentation formatting with `markdown-editor`.

## Supporting Documents & Resources

All architectural documentation lives in `docs/`:

- [language.md](docs/language.md) — Shared architectural vocabulary.
- [interface-design.md](docs/interface-design.md) — Multi-option design rules.
- [req-format.md](docs/req-format.md) — Decision document schema.
- [tdd.md](docs/tdd.md) — Test-driven development workflow.
- [fp-patterns.md](docs/fp-patterns.md) — FP design patterns.
- [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md) — Domain glossary schema.

## Cross-Skill References

- **`requirements-review`** — Grilling interface designs (Step 4).
- **`markdown-editor`** — Markdown validation and linting.
- **Language Skills:** `clojure-programmer`, `gnur-programmer`,
  `haskell-programmer`, `lean-programmer`, `python-programmer`,
  `shell-programmer`.
