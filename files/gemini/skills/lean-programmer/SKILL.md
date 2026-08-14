---
name: lean-programmer
description: >-
  Develop, refactor, prove, and review Lean 4 codebases (.lean, lakefile.lean,
  lakefile.toml). Enforces functional programming idioms, dependent types,
  totality, FBIP optimisation, Mathlib 4 conventions, and Lake tooling.
---

Guide Lean 4 development emphasising purely functional idioms, dependent type
safety, totality, and idiomatic Lake build tooling.

## Core Conventions & Style

- **Naming:** `camelCase` for functions/variables (`def`), `PascalCase` for
  types, structures, inductive types, and theorems.
- **Line Length & Indentation:** 2-space indentation; hard-wrap comments and
  docstrings at 80 columns.
- **Unicode:** Use idiomatic Unicode (`α`, `β`, `→`, `×`, `⊕`, `⟨x, y⟩`).
- **Import Hygiene:** Use explicit module imports. Avoid top-level blanket
  `open`; prefer `open ... in`, scoped sections, or `open scoped`.
- **Namespaces:** Wrap files in namespaces matching their file hierarchy
  (e.g. `MyProject.Data.Graph`).

## Functional Programming & Type Design

- **Totality & Termination:** Ensure all functions are total. Prefer
  `termination_by` or structural recursion over `partial def`. Handle domain
  failures via `Option` or `Except`.
- **Dependent Types & Structures:**
  - Use `structure` for record types with named fields.
  - Use `inductive` sum types to prevent boolean blindness.
  - Use `Subtype` (`{x : α // p x}`) to embed proofs within data types.
  - Use `nomatch` / `False.elim` for impossible code branches.
- **Type Classes:** Implement lawful type class instances (`LawfulBEq`,
  `LawfulFunctor`) when defining custom algebra.
- **Modes:** Prefer clean term-mode for functions; use tactic-mode (`by`) with
  structured subgoals (`have`, `show`) for non-trivial theorems.

## Performance & FBIP (Functional But In-Place)

- **In-Place Updates:** Leverage FBIP with structure updates
  (`{ s with field := val }`) and `Array.set` to enable destructive updates
  when reference counts are 1.
- **Attributes:** Mark small higher-order helpers with `@[inline]` and
  equational lemmas with `@[simp]`.

## Documentation & Tooling

- **Docstrings (`doc-gen4`):** Document top-level definitions with `/-- ... -/`
  including parameter descriptions and markdown examples.
- **Lake & Mathlib:** Use Lake commands (`lake build`, `lake test`,
  `lake exe cache get`) or `Makefile` targets.
- **Linters:** Enable built-in linters (`set_option linter.all true`).

## Review & Output Contract

When reviewing or refactoring Lean 4 code, structure output as follows:

1. **Summary:** Architectural overview and type design.
2. **Totality & Termination:** Non-terminating functions or improper `partial`
   usage.
3. **Type Safety & Proofs:** Subtyping opportunities, missing lawful instances,
   or fragile tactic scripts.
4. **FBIP & Performance:** In-place update opportunities and attribute usage.
5. **Tooling & Docs:** Docstrings, namespace hygiene, and Lake configuration.
6. **Suggested Code / Diff:** Idiomatic, verified Lean 4 implementation.

## Resources

- Language: [Lean 4 Documentation](https://lean-lang.org/lean4/doc/)
- Build Tool: [Lake Documentation](https://lean-lang.org/lean4/doc/lake/)
- Ecosystem: [Mathlib 4 Documentation](https://leanprover-community.github.io/mathlib4_docs/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
