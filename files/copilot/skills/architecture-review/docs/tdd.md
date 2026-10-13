# Test Driven Design

Write the test first. Then write code to make it pass. This is non-negotiable —
it applies to every refinement candidate, every new module, and every interface
change.

## The Cycle

### 1. Red — Write a Failing Test

Write a test at the intended module interface _before_ any implementation
exists. The test should:

- Describe the behaviour you want, not the implementation you're planning
- Use the module's public interface only — no reaching into internals
- Fail with a clear, informative message

For pure functions, prefer **property-based tests** that express invariants over
example-based tests that check specific values.

### 2. Green — Minimum Implementation

Write the smallest amount of code that makes the test pass. Resist the urge to
generalise or optimise. The goal is a green test, not a perfect implementation.

### 3. Refactor — Refine

With a green test as your safety net:

- Refine the module (merge low-leverage modules, simplify the interface)
- Extract pure functions from effectful code
- Improve naming using the project's `GLOSSARY.md` vocabulary (normally at
  project root or in `docs/`)
- Delete old low-leverage module tests that are now redundant (see
  [abstraction-refinement.md](abstraction-refinement.md))

The tests must stay green throughout.

## Language-Specific Tooling

### Haskell

- **Framework**: HSpec for structured specs, tasty for test organisation
- **Property testing**: QuickCheck or Hedgehog for properties over algebraic
  data types
- **Running**: `cabal test` or `stack test` or `make test`
- **Coverage**: HPC (Haskell Program Coverage)
- Refer to `haskell-programmer` for coding standards

### Clojure

- **Framework**: `clojure.test` with `deftest` / `is`
- **Property testing**: `test.check` for generative tests on pure functions
- **Runner**: kaocha for richer output
- **Running**: `clojure -M:test` or `make test`
- Refer to `clojure-programmer` for conventions

### Python

- **Framework**: pytest
- **Property testing**: Hypothesis for property-based tests
- **Running**: `pytest` or `make test`
- **Linting**: ruff for style enforcement
- Refer to `python-programmer` for standards

## When to Delete Tests

After refining a module's abstraction, old unit tests on the now-merged
low-leverage modules become waste. Delete them when:

- The behaviour they tested is now covered by tests at the refined module's
  interface
- They test internal implementation details that no longer exist
- They would break on any internal refactor (they were testing past the
  interface)

Keep tests that cover genuinely distinct edge cases not exercised by the
interface-level tests.

## Property-Based Testing

For pure functions — the core of any well-designed FP module — property-based
tests are strictly preferred:

- **Express invariants**, not examples: "reversing a list twice yields the
  original" rather than "reverse [1,2,3] == [3,2,1]"
- **Generate inputs** rather than hand-picking them
- **Shrink failures** to minimal counterexamples
- **Document laws** — if your typeclass has laws, test them as properties
