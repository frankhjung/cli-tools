---
name: lean-programmer
description: >-
  Develop, refactor, prove, and review Lean 4 codebases (.lean, lakefile.lean,
  lakefile.toml). Use this skill when developing, refactoring, proving,
  testing, or reviewing Lean 4 codebases. Enforces functional programming
  idioms, dependent types, totality, FBIP optimisation, Mathlib 4 conventions,
  and Lake tooling.
---

# Lean Programmer

Guide Lean 4 development emphasising purely functional idioms, dependent type
safety, totality, robust proof construction, and idiomatic Lake build tooling.

## Core Conventions & Style

- **Naming:** `camelCase` for functions and terms (`def`); `PascalCase` for
  types, structures, inductive families, and theorem identifiers. Follow
  Mathlib naming conventions (e.g. `add_comm`, `mul_assoc`) for lemmas.
- **Line Length & Indentation:** 2-space indentation; hard-wrap comments and
  docstrings at 80 columns.
- **Unicode:** Use standard Lean 4 Unicode symbols (`α`, `β`, `→`, `×`, `⊕`,
  `⟨x, y⟩`, `∀`, `∃`, `↔`).
- **Import Hygiene:** Use explicit module imports. Avoid top-level blanket
  `open`; prefer `open ... in`, scoped sections, or `open scoped`.
- **Namespaces:** Wrap files in hierarchical namespaces matching their file
  path (e.g. `MyProject.Data.Graph`).

## Functional Programming & Type Design

- **Totality & Termination:** Ensure all functions are total. Prefer
  structural recursion or explicit `termination_by` measures over `partial def`.
  Handle domain failures via `Option` or `Except`.
- **Dependent Types & Structures:**
  - Use `structure` for record types with named fields and inductive proofs.
  - Use `inductive` sum types to prevent boolean blindness.
  - Use `Subtype` (`{x : α // p x}`) to embed validity proofs directly within
    data representations.
  - Use `nomatch` / `False.elim` for impossible code branches.
- **Lawful Classes:** Implement lawful type class instances (`LawfulBEq`,
  `LawfulFunctor`) when defining custom algebraic or collection types.
- **Modes:** Prefer clean term-mode definitions for functions; reserve
  tactic-mode (`by`) with structured subgoals (`have`, `show`) for non-trivial
  theorems.

## Performance & FBIP (Functional But In-Place)

- **In-Place Updates:** Leverage FBIP with structure updates
  (`{ s with field := val }`) and `Array.set` to enable destructive updates
  when runtime reference counts equal 1.
- **Attributes:** Mark small higher-order functions with `@[inline]` and
  equational lemmas with `@[simp]`.

## Agent Development & Proof Workflow

- **No Interactive Infoview:** You lack an interactive IDE Infoview socket.
  Validate files and check proof states via CLI tooling:
  - `lake env lean <file>` for immediate compiler diagnostics and proof checks.
  - `lake build` for project-wide compilation.
  - `lake test` to run test suites.
- **Goal Inspection:** When developing complex proofs without Infoview, inspect
  intermediate states by inserting temporary `#check`, `#eval`, or `sorry`
  markers with compiler invocations.
- **Proof Robustness:** Avoid fragile non-terminal tactic chains. Prefer
  explicit lemmas (`simp only [...]` over bare `simp`) to prevent proofs from
  breaking across toolchain updates.
- **Scratch Files:** Store one-off proof experiments and diagnostic scripts in
  the session scratch directory to maintain workspace cleanliness.

## Documentation & Tooling

- **Docstrings (`doc-gen4`):** Document top-level definitions with `/-- ... -/`
  blocks, including parameter descriptions and markdown examples.
- **Lake & Mathlib:** Use Lake commands (`lake build`, `lake test`,
  `lake exe cache get`) or coordinate via `Makefile` targets.
- **Linters:** Enable built-in linters (`set_option linter.all true`).

## Review & Output Contract

When reviewing or refactoring Lean 4 code, organise findings into:

1. **Summary:** Architectural overview, design quality, and verification scope.
2. **Totality & Termination:** Non-terminating functions or improper `partial`
   usage.
3. **Type Safety & Proofs:** Subtyping opportunities, missing lawful instances,
   or fragile tactic scripts.
4. **FBIP & Performance:** In-place update opportunities and attribute usage.
5. **Tooling & Docs:** Docstrings, namespace hygiene, and Lake configuration.
6. **Suggested Code / Diff:** Idiomatic, verified Lean 4 implementation.

## Cross-Skill References

- **`architecture-review`** — Pure functional architecture, totality, and
  domain modelling.
- **`requirements-review`** — Formal specification of invariants, properties,
  and theorem statements.
- **`makefile-programmer`** — Coordinate `Makefile` targets for Lake builds and
  tests.
- **`markdown-editor`** — Format docstrings and module documentation.

## Resources

- Language: [Lean 4 Documentation](https://lean-lang.org/lean4/doc/)
- Build Tool: [Lake Documentation](https://lean-lang.org/lean4/doc/lake/)
- Ecosystem: [Mathlib 4 Documentation][mathlib-doc]
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)

[mathlib-doc]:
https://leanprover-community.github.io/mathlib4_docs/
