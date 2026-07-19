---
name: lean-programmer
description: >-
  Review Lean 4 codebases emphasising functional
  programming idioms and dependent type safety.
---

Specialises in reviewing Lean 4 codebases using modern
purely functional programming idioms. Ensures clean,
composable code; total functions; dependent type safety;
proper documentation; and adherence to best practices
using Lean's built-in tools and the Lake build system.

This skill enforces:

- Pure, strict functional programming
- Totality and provable termination
- Proper use of dependent types and structures
- Clear function and module boundaries
- Idiomatic use of type classes and monads
- Clean-code principles appropriate for Lean 4

## Core Principles

### Coding Style

- Use 2 spaces for indentation.
- Limit lines to 80–100 characters.
- Use `camelCase` for variable names, function names
  (`def`), and class methods.
- Use `PascalCase` for types, namespaces, `structure`,
  `inductive` definitions, and type classes.
- Use idiomatic Unicode characters to mirror mathematical
  notation:
  - `α`, `β` for type variables
  - `→` for function arrows
  - `×` for product types
  - `⊕` for sum types
  - `⟨x, y⟩` for anonymous constructors
- Use the pipeline operator (`|>`) or reverse application
  (`<|`) to chain operations cleanly.
- All generated text output, including markdown content
  and descriptions, must adhere to an 80-column line
  limit.

### Functional Programming (FP) Foundations

- Encourage **total functions**. Lean expects functions
  to terminate.
- Avoid `partial def` unless absolutely necessary (e.g.,
  infinite loops in a REPL).
- If Lean's termination checker fails, prefer supplying
  `termination_by` or restructuring the code to use
  structural recursion over using `partial`.
- Promote higher-order functions from the standard
  library (`List.map`, `List.foldl`, `List.filter`).
- Use `do` notation for monadic code (e.g., `IO`,
  `StateT`, `ReaderT`) to keep effectful programming
  clean while remaining purely functional.
- Encourage pattern matching (`match ... with`) and
  `if let` for branching logic.

### Type Safety & Dependent Types

- Require explicit type signatures for all top-level
  definitions (`def`, `theorem`, `abbrev`).
- Encourage:
  - `structure` for data modelling with named fields
    (records).
  - `inductive` types for sum types and branching logic
    (avoid boolean blindness).
  - `Subtype` (or `{x : α // p x}`) to constrain types
    and blend proofs with programs (e.g., guaranteed
    ordered lists, bounded integers).
- Use `False.elim` / `nomatch` (Principle of Explosion)
  to handle logically impossible code paths rather than
  relying on default or "magic" values.
- Emphasise type classes (`class` and `instance`) over
  explicit dictionary passing for polymorphism (e.g.,
  `Inhabited`, `ToString`, `BEq`).

### Clean Code & Architecture

- Functions should be small, focused, and composable.
- Use `namespace` blocks to encapsulate logic and prevent
  namespace pollution.
- Avoid:
  - Deeply nested pattern matches (prefer helper
    functions or simultaneous matching).
  - Unnecessary monad transformers when simple effects
    will do.
  - Mixing complex theorem proving inline with business
    logic (keep proofs separate or abstracted via helper
    theorems).
- Prefer pure logic at the core and push `IO` and
  effectful boundaries to the edges of the application.

### Documentation Standards (doc-gen4)

Every top-level definition, structure, and class should
include Lean's official documentation comment style
(`/-- ... -/`):

- Summary description of the function or type.
- Explanation of inputs and outputs.
- Examples where applicable.
- Markdown formatting is supported and encouraged.

Example:

```lean
/--
Computes the average of a list of numbers.
Returns `0` if the list is empty.
-/
def average (xs : List Float) : Float :=
  match xs with
  | [] => 0.0
  | _  => xs.foldl (· + ·) 0.0 / xs.length.toFloat
```

### Build System (Lake)

When a `lakefile.lean` (or `lakefile.toml`) is present in
the project root, it must be used as the primary interface
for development tasks.

- `lake build`: Compile the project.
- `lake test`: Execute the test suite (if configured).
- `lake clean`: Remove build artefacts.
- `lake env printPaths`: Display resolved search paths.

If a `Makefile` wrapper is present, prefer `make` targets
over raw `lake` commands.

## Resources

- Language: [Lean 4 Documentation](https://lean-lang.org/lean4/doc/)
- Build: [Lake Documentation](https://lean-lang.org/lean4/doc/lake/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
  (Australian English)
