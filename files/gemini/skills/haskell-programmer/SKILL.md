---
name: haskell-programmer
description: >-
  Review Haskell codebases emphasising functional programming
  idioms, documentation, build tooling, and architecture.
---

# Haskell Programmer

This skill specialises in reviewing Haskell codebases using modern functional
programming idioms. It ensures clean, composable code; strong type safety;
proper documentation; and adherence to best practices using tools such as
HLint, Haddock, Fourmolu/Ormolu, and Cabal/Stack conventions.

## Core Principles

### Coding Style

- Use 2 spaces for indentation.
- Limit Haskell code lines to 80 characters.
- Use `camelCase` for variable and function names.
- Use `PascalCase` for type, constructor, and module names.
- Use single characters for generic type variables (e.g. `a`, `b`, `m`).
- Use [hlint][hlint-url] to enforce style guidelines and suggest code
  simplifications.
- Use source formatters such as [fourmolu][fourmolu-url], [ormolu][ormolu-url],
  or [stylish-haskell][stylish-haskell-url] for consistent layout.
- Use [cabal-fmt][cabal-fmt-url] for consistent `.cabal` file formatting.

### GHC Warnings

Enable at minimum `-Wall` in the project's `.cabal` file under `ghc-options`.
Prefer `-Wall -Wextra` for stricter coverage. Key warnings to never suppress:

- `-Wincomplete-patterns` — catches non-exhaustive pattern matches
- `-Wmissing-signatures` — enforces top-level type signatures
- `-Wunused-imports` — keeps import lists clean

Suppress individual warnings only with an inline `{-# OPTIONS_GHC -Wno-... #-}`
pragma accompanied by a justifying comment.

### GHC Language Editions and Extensions

Declare modern GHC language editions (e.g. `default-language: GHC2021` or
`GHC2024`) in `.cabal` files to enable standard extensions cleanly.

**Commonly accepted extensions:**

- `DerivingStrategies` (required for `deriving stock` / `deriving newtype`)
- `OverloadedStrings`
- `ScopedTypeVariables`
- `GeneralizedNewtypeDeriving`
- `TypeApplications`
- `LambdaCase`
- `TupleSections`

**Use with caution (justify in a comment):**

- `TemplateHaskell`
- `UndecidableInstances`
- `TypeFamilies`

Avoid global extensions that change semantics silently (e.g. `OverloadedLists`,
`RebindableSyntax`).

### Import Conventions

- Use explicit import lists for unqualified imports to keep namespaces clear
  and aid readability.
- Prefer qualified imports for modules with common names (e.g. `import
  qualified Data.Map.Strict as Map`).
- Group imports in this order, separated by a blank line:
  1. `Prelude` overrides (if any)
  2. Third-party / library imports
  3. Project-internal imports

### Strictness and Space Leak Prevention

Avoid space leaks resulting from lazy evaluation in long-running processes or
aggregations:

- **Strict Data Fields:** Use strictness annotations on data constructor fields
  by default (e.g. `data User = User !Text !Int`).
- **Strict Collections:** Always import strict data structure modules (e.g.
  `Data.Map.Strict`, `Data.Set`, `Data.ByteString`).
- **Strict Accumulators:** Prefer strict folds (`Data.List.foldl'`) over lazy
  folds (`foldl`) for numeric or stateful accumulation.
- **Strict Evaluation:** Use `BangPatterns` or `seq` / `deepseq` when evaluating
  nested values before passing across thread or iteration boundaries.

### Functional Programming (FP) Foundations

- Encourage pure, total functions.
- Avoid partial functions (`head`, `tail`, `fromJust`, `read`) unless proven
  safe.
- Promote:
  - Higher-order functions (`map`, `foldr`, `foldl'`, `traverse`, `sequence`).
  - Applicative/monadic patterns where appropriate.
  - Function composition (`(.)`) and pipelines.
  - Point-free style when it improves clarity.
- Prefer algebraic data types and pattern matching over boolean logic.

### Type Safety and Type System Usage

- Require explicit type signatures for all top-level functions and values.
- Encourage:
  - `newtype` wrappers over type synonyms for semantic type safety.
  - Sum types for domain variants rather than magic values or strings.
  - Record syntax with strict fields for complex entities.
  - Explicit deriving strategies (`deriving stock`, `deriving newtype`,
    `deriving anyclass`).

### Effect Management and Architecture

- Keep core domain logic pure; push IO and side effects to application edges.
- Prefer lightweight effect patterns such as `ReaderT env IO` for application
  environment and capability injection over deeply nested monad transformer
  stacks.
- Consider modern effect libraries (e.g. `effectful`) when complex effect
  composition is required.
- Decompose long monadic pipelines into focused pure helper functions.

### Documentation Standards (Haddock)

Every top-level function and type should include Haddock documentation:

- Summary description.
- Parameter explanations via `-- ^`.
- Return value descriptions and invariants.
- Example usage via `>>>`.
- Document required typeclass laws for custom instances.

Example:

```haskell
-- | Compute the arithmetic mean of a list of numbers.
--
-- Returns 'Nothing' for an empty list.
--
-- >>> average [1, 2, 3, 4]
-- Just 2.5
--
-- >>> average []
-- Nothing
--
-- ^ list of numeric values
average :: Fractional a => [a] -> Maybe a
average [] = Nothing
average xs = Just (sum xs / fromIntegral (length xs))
```

### Testing

- Use [Tasty][tasty-url] as the primary test framework for new projects, with
  `tasty-hunit` for unit tests and `tasty-quickcheck` for property testing.
  `Hspec` is also acceptable.
- Prefer property-based tests (QuickCheck / Hedgehog) over example tests
  wherever invariants can be expressed.
- Place tests in `test/` following the same module hierarchy as `src/`.

### Build System (GNU Make)

When a `Makefile` is present in the project root, use it as the primary
interface for development tasks. Prefer `make` commands over raw `cabal` or
`stack` commands.

- **Default Target:** Running `make` performs formatting, checking, building,
  and testing (`format check build test`).
- **Standard Targets:**
  - `make format`: Format source files (`cabal-fmt`, `fourmolu`,
    `stylish-haskell`).
  - `make check`: Run linters and quality checks (`hlint`, `cabal check`).
  - `make build`: Compile the project.
  - `make test`: Execute the test suite.
  - `make doc`: Generate Haddock documentation.
  - `make setup`: Initialise dependencies and environment.
  - `make clean`: Remove build artefacts.

## Resources

- Language: [Haskell Documentation][haskell-doc-url]
- Tooling: [Haskell Language Server][hls-url]
- Package Index: [Hackage][hackage-url]
- Dictionary: [Macquarie Dictionary][macquarie-dict-url] (Australian English)

[hlint-url]: https://github.com/ndmitchell/hlint
[fourmolu-url]: https://github.com/fourmolu/fourmolu
[ormolu-url]: https://github.com/tweag/ormolu
[stylish-haskell-url]: https://github.com/haskell/stylish-haskell
[cabal-fmt-url]: https://github.com/phadej/cabal-fmt
[tasty-url]: https://hackage.haskell.org/package/tasty
[haskell-doc-url]: https://www.haskell.org/documentation/
[hls-url]: https://haskell-language-server.readthedocs.io/
[hackage-url]: https://hackage.haskell.org/
[macquarie-dict-url]: https://www.macquariedictionary.com.au/
