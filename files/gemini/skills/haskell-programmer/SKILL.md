---
name: haskell-programmer
description: >-
  Develop, refactor, test, and review Haskell codebases (.hs, .lhs, .cabal).
  Use this skill when developing, refactoring, compiling, testing, or
  reviewing Haskell codebases (.hs, .lhs, .cabal, package.yaml, Setup.hs).
  Enforces modern functional idioms, total functions, strictness, and idiomatic
  tooling.
---

# Haskell Programmer

Guide Haskell development emphasising pure functional idioms, strong type
safety, total functions, strictness, and idiomatic tooling.

## Core Conventions & Type Design

- **Language & Style:** 2-space indentation; hard-wrap code comments and prose
  at 80 columns. Use `camelCase` for values/functions and `PascalCase` for
  types/modules.
- **Language Edition:** Declare modern language editions (`GHC2021` or
  `GHC2024`) in `.cabal` files.
- **Modern Extensions:** Leverage `OverloadedRecordDot` and `NoFieldSelectors`
  for clean record access. Use `OverloadedStrings` for string literals.
- **GHC Warnings:** Enable `-Wall` (or `-Wall -Wextra`). Never suppress
  `-Wincomplete-patterns`, `-Wmissing-signatures`, or `-Wunused-imports`
  without an explicit, justified comment.
- **Type Safety & Data:**
  - Prefer `newtype` wrappers over type synonyms for semantic domain types.
  - Use smart constructors returning `Either` or `Maybe` when types enforce
    invariants, keeping data constructors private.
  - Use sum types for domain variants rather than magic values or strings.
  - Require explicit deriving strategies (`deriving stock`, `deriving newtype`,
    `deriving anyclass`, `deriving via`).
  - Require top-level type signatures for all exported bindings.
- **Purity & Totality:**
  - Avoid partial functions (`head`, `tail`, `fromJust`, `read`); use total
    alternatives (`Data.Maybe`, `Data.List.NonEmpty`).
  - Push IO and side effects to application boundaries using `ReaderT env IO`
    or lightweight effect patterns (e.g. `effectful`).

## Strictness & Performance

- **Strict Constructor Fields:** Use strictness annotations on data fields by
  default (e.g. `data User = User !Text {-# UNPACK #-} !Int`).
- **Strict Data Structures:** Always prefer strict collection modules (e.g.
  `Data.Map.Strict`, `Data.Set`, `Data.ByteString`).
- **Strict Folds:** Use strict folds (`Data.List.foldl'`) over lazy `foldl` to
  prevent accumulator space leaks.

## Tooling, Testing & Workflow

- **Documentation (Haddock):** Document all exported types and functions with
  parameter explanations (`-- ^`), return contracts, and runnable examples
  (`>>>`).
- **Testing:** Use `Tasty` (with `tasty-hunit` and `tasty-quickcheck` /
  `hedgehog`) for property and unit tests under `test/`. Prefer property-based
  tests for pure domain logic.
- **Formatting & Linting:** Use `fourmolu` / `ormolu`, `hlint`, and
  `cabal-fmt`.
- **Task Runner:** Use `Makefile` targets (`make format`, `make check`,
  `make build`, `make test`, `make doc`).

## Review & Output Contract

When reviewing or refactoring Haskell code, organise findings into:

1. **Summary:** Architectural overview and type design quality.
2. **Type Safety & Totality:** Partial functions, missing type signatures, or
   loose primitives.
3. **Strictness & Space Leaks:** Unannotated fields, lazy folds, or unsafe
   accumulator chains.
4. **Tooling & Haddock:** Missing documentation examples, Cabal settings, or
   HLint opportunities.
5. **Suggested Code / Diff:** Clean, idiomatic Haskell implementation.

## Cross-Skill References

- **`architecture-review`** — Pure core / effectful shell, polymorphic
  boundaries, and FP refactoring.
- **`requirements-review`** — Stress-test domain invariants and type models.
- **`makefile-programmer`** — Coordinate `Makefile` targets for builds and
  tests.
- **`markdown-editor`** — Format and lint documentation and design records.

## Resources

- Language: [Haskell Documentation](https://www.haskell.org/documentation/)
- API Search: [Hoogle](https://hoogle.haskell.org/)
- Linters & Style: [HLint](https://github.com/ndmitchell/hlint),
  [Fourmolu](https://github.com/fourmolu/fourmolu)
- Package Index: [Hackage](https://hackage.haskell.org/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
