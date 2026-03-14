---
name: improve-codebase-architecture
description: Improve codebase architecture.
---

Identify low-leverage Modules and propose FP-idiomatic refinements that increase leverage.
Optimize for testability, composability, and user readability.
Use `GLOSSARY.md` for domain terms and `docs/REQ-*` for prior decisions.

## Operating Mode

Read-only until the user selects a candidate (step 2).

- Do not edit files.
- Do not create tests.
- Do not run build or lint commands that mutate the workspace.

After selection, design the interface (step 3), stress-test it (step 4), then
follow TDD (step 5).

### Orchestration

Multi-turn skill. Use `update_topic` at each phase:

1. **Step 1 (Explore)**: Title "Exploring Architecture", summary of search
   strategy.
2. **Step 2 (Candidates)**: Title "Architecture Candidates", summary of
   findings.
3. **Step 3 (Design)**: Title "Designing Interface", summary of alternatives.
4. **Step 4 (Grill)**: Title "Grilling Design", summary of constraints
  resolved.
5. **Step 5 (Implement)**: Title "Implementing [Name]", summary of TDD plan.

## Vocabulary

Use [docs/language.md](docs/language.md) terms exactly. Avoid "component,"
"service," or "API." Use "boundary" only in "push effects to the boundary."

Terms (see `language.md` for full definitions): **Module**, **Interface**
(Contract), **Leverage** (high/low), **Polymorphic Boundary**, **Capability
Interface**, **Adapter**.

Use `GLOSSARY.md` for domain terms; respect existing `docs/REQ-*` decisions.

Key principles:

- **Pure core, effectful shell**
- **Deletion test** — if removing the module spreads complexity across N
  callers, it earns its keep
- **The interface is the test surface**
- **One adapter = hypothetical. Two = real.**

## Process

### 1. Explore

Read the project's `GLOSSARY.md` and any `docs/REQ-NNN-slug.md` in the area you
are touching first. See [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md) for the
glossary format.

Walk the codebase and record friction:

- Where does understanding one concept require bouncing between many small
  modules?
- Where are modules **low-leverage** — interface nearly as complex as the
  implementation?
- Where have pure functions been extracted just for testability, but the real
  bugs hide in how they are called (no **locality**)?
- Where do tightly-coupled modules leak across their polymorphic boundaries?
- Which parts are untested, or hard to test through their current interface?

Run the **deletion test** on each low-leverage candidate: would
deleting it concentrate complexity, or just move it?

### 2. Present Candidates

List refinement candidates. For each candidate include:

- **Files** — which files/modules are involved
- **Problem** — why the current architecture causes friction
- **Solution** — plain English, framed as FP patterns (see
  [docs/fp-patterns.md](docs/fp-patterns.md))
- **Benefits** — locality, leverage, and how tests would improve

Use `GLOSSARY.md` vocabulary for the domain and
[docs/language.md](docs/language.md) vocabulary for the architecture. If
`GLOSSARY.md` defines "Order," talk about "the Order module" — not "the
FooBarHandler."

**REQ conflicts**: only surface when friction warrants revisiting the REQ. Mark
clearly (e.g. _"contradicts REQ-007 — but worth reopening because…"_).

Do NOT propose interfaces yet. Ask the user: "Which of these would you like to
explore?"

### 3. Design the Interface

Follow the process in [docs/interface-design.md](docs/interface-design.md).
Design at least three genuinely different alternatives before choosing.

### 4. Grilling Loop

Use the `grill-me` skill to stress-test the design. If
`activate_skill(name="grill-me")` is available, call it first. Otherwise, run
the same grilling checklist inline: constraints, dependencies, module shape,
what sits behind the polymorphic boundary, and which tests survive.

Apply updates inline as decisions crystallise:

- **New concept not in `GLOSSARY.md`?** Add the term. Create the file lazily if
  it does not exist.
- **Sharpening a fuzzy term?** Update `GLOSSARY.md` right there.
- **User rejects the candidate with a load-bearing reason?** Offer a REQ: _"Want
  me to record this so future reviews do not re-suggest it?"_ Only offer when
  the reason would help a future explorer. See
  [docs/req-format.md](docs/req-format.md).

### 5. Write Tests First

Once the user picks a candidate, follow the TDD workflow in
[docs/tdd.md](docs/tdd.md):

1. **Red** — failing test at the intended interface
2. **Green** — minimum implementation to pass
3. **Refactor** — refine the module, keeping tests green

For pure functions, prefer property-based tests (QuickCheck, test.check,
Hypothesis). See [docs/fp-patterns.md](docs/fp-patterns.md) for how pure-core
architecture makes this natural.

### 6. Build

After implementation starts, use `make` or the project's standard build process.

## Exploration Tips

When exploring (Step 1), use these patterns:

- **`grep_search`** to find high import fan-in or large public surfaces.
- **`file_search`** with glob patterns to find clusters of small related files.
- **Look for pass-through code** where a caller just formats data for a
  downstream dependency.
- **Identify untested logic** by comparing exports to test files.

## Supporting Documents

All documents live in `docs/`:

- [language.md](docs/language.md) — shared vocabulary
- [abstraction-refinement.md](docs/abstraction-refinement.md) — how to refine
  abstractions safely
- [interface-design.md](docs/interface-design.md) — design-it-twice process
- [req-format.md](docs/req-format.md) — REQ document format
- [tdd.md](docs/tdd.md) — test-driven design workflow
- [fp-patterns.md](docs/fp-patterns.md) — FP patterns and leverage implications

Additional:

- [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md) — format for project `GLOSSARY.md`

## Cross-Skill References

- **`grill-me`** — grilling loop (step 4)
- **`markdown-validator`** — validate generated markdown
- **`haskell-programmer`** — Haskell standards, purity, HLint
- **`clojure-programmer`** — Clojure conventions, data orientation, protocols
- **`python-programmer`** — Python functional style, ruff, typing, pytest
