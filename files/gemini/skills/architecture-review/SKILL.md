---
name: architecture-review
description: Improve codebase architecture with FP-idiomatic refinements.
---

Identify low-leverage Modules and propose FP-idiomatic refinements that
increase leverage. Optimise for testability, composability, and readability. Use
`GLOSSARY.md` for domain terms and `docs/REQ-*` for prior decisions.

## Operating Mode

Read-only until the user selects a candidate (step 2).

- Do not edit files.
- Do not create tests.
- Do not run build or lint commands that mutate the workspace.

After selection, design the interface (step 3), stress-test it (step 4), plan
migration (step 5), then follow TDD (step 6).

### Orchestration

Multi-turn skill. Use `update_topic` at each phase:

1. **Step 1 (Explore)**: Title "Exploring Architecture", summary of search
   strategy.
2. **Step 2 (Candidates)**: Title "Architecture Candidates", summary of
   findings.
3. **Step 3 (Design)**: Title "Designing Interface", summary of alternatives.
4. **Step 4 (Grill)**: Title "Grilling Design", summary of constraints
   resolved.
5. **Step 5 (Migrate)**: Title "Migration Strategy", summary of transition.
6. **Step 6 (Implement)**: Title "Implementing [Name]", summary of TDD plan.
7. **Step 7 (Verify)**: Title "Verifying Architecture", summary of build checks.

## Vocabulary

Refer to [docs/language.md](docs/language.md) for all architectural terms and
definitions. Avoid generic terms like "component," "service," or "API."

Core architectural terms defined in `language.md`: **Module**, **Interface**
(Contract), **Leverage** (high/low), **Polymorphic Boundary**, **Capability
Interface**, and **Adapter**.

Use `GLOSSARY.md` for project domain terms and respect `docs/REQ-*` decisions.

## Process

### 1. Explore

Read the project's `GLOSSARY.md` and any `docs/REQ-NNN-slug.md` in the target area.
See [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md) for glossary formatting rules.

Walk the codebase to record architectural friction and quantitative metrics:

- **High Fan-in / Fan-out:** Modules imported across many contexts or depending
  on many downstream components.
- **Low Leverage:** Modules where the public interface is nearly as complex as
  the internal implementation.
- **Lost Locality:** Pure functions extracted solely for unit tests, while bugs
  concentrate in caller invocation logic.
- **Leaky Boundaries:** Tightly coupled modules leaking implementation details
  across polymorphic boundaries.
- **Untested Surface:** Core domain logic hard to test through current interface.

Run the **deletion test** on candidate modules: would deleting the module
concentrate complexity in one place, or scatter it across callers?

### 2. Present Candidates

List refinement candidates. For each candidate include:

- **Files** — involved files/modules
- **Problem** — architectural friction and metrics
- **Solution** — plain English, framed using FP patterns (see
  [docs/fp-patterns.md](docs/fp-patterns.md))
- **Benefits** — expected leverage, locality, and testability improvements

Use `GLOSSARY.md` vocabulary for domain concepts and
[docs/language.md](docs/language.md) for architecture.

**REQ conflicts:** Surface only when friction warrants reopening prior REQs.

Do NOT propose concrete interfaces yet. Ask the user: "Which of these candidates
would you like to explore?"

### 3. Design the Interface

Follow [docs/interface-design.md](docs/interface-design.md). Design at least
three genuinely different alternatives before selecting a recommendation.

### 4. Grilling Loop

Use the `grill-me` skill to stress-test the interface design. If
`activate_skill(name="grill-me")` is available, call it first. Otherwise, run
the grilling checklist inline.

Apply updates inline as decisions crystallise:

- Add new terms to `GLOSSARY.md` lazily.
- Update `GLOSSARY.md` definitions when clarified.
- Offer a REQ document when a load-bearing decision is rejected or affirmed. See
  [docs/req-format.md](docs/req-format.md).

### 5. Plan Migration Strategy

Before changing code, outline a backward-compatible migration plan (e.g.
Strangler Fig pattern). Ensure callers can transition incrementally without
breaking the build.

### 6. Write Tests First (TDD)

Follow the TDD workflow in [docs/tdd.md](docs/tdd.md):

1. **Red:** Write failing tests against the refined interface.
2. **Green:** Minimum implementation to pass.
3. **Refactor:** Clean implementation while keeping tests green.

Prefer property-based tests for pure functions.

### 7. Build and Verify

After implementation:

- Execute build and test suites (`make`, `cabal test`, `pytest`).
- Verify dead-code cleanup — remove unused legacy modules and imports.
- Validate generated markdown documentation using `markdown-validator`.

## Exploration Tips

- **`grep_search`** for high import fan-in or public export lists.
- **`file_search`** for clusters of related files.
- **Look for pass-through code** formatting data solely for downstream calls.

## Supporting Documents

All supporting documents live in `docs/`:

- [language.md](docs/language.md) — shared vocabulary
- [interface-design.md](docs/interface-design.md) — design-it-twice and
  dependency strategy
- [req-format.md](docs/req-format.md) — REQ document format
- [tdd.md](docs/tdd.md) — test-driven design workflow
- [fp-patterns.md](docs/fp-patterns.md) — FP patterns and leverage implications

Additional:

- [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md) — format for project `GLOSSARY.md`

## Cross-Skill References

- **`grill-me`** — grilling loop (step 4)
- **`markdown-validator`** — validate generated markdown
- **`haskell-programmer`** — Haskell type safety, purity, HLint
- **`clojure-programmer`** — Clojure data orientation, protocols
- **`python-programmer`** — Python functional style, ruff, typing, pytest
