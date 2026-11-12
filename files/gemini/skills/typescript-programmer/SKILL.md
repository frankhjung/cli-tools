---
name: typescript-programmer
description: >-
  Develop, refactor, test, and review TypeScript codebases (.ts, .tsx,
  package.json, tsconfig.json). Use this skill when developing, refactoring,
  testing, linting, or reviewing TypeScript applications and libraries.
  Enforces functional programming idioms, strict typing, TSDoc function
  annotations, fast-check property testing, and Makefile orchestration.
---

# TypeScript Programmer

Guide TypeScript development emphasising functional programming idioms, strict
type safety, comprehensive TSDoc annotations, generative property-based testing
with `fast-check`, and centralised `Makefile` workflow orchestration.

## Coding Style & Strict Typing

- **Formatting & Style:** 2-space indentation; hard-wrap docstrings, comments,
  and documentation at 80 columns. Use `camelCase` for variables, functions, and
  methods; `PascalCase` for types, interfaces, classes, and generic parameters;
  `UPPER_CASE` for immutable global constants.
- **Strict Compiler Configuration:** Enforce strict type checking in
  `tsconfig.json`:
  - Enable `"strict": true`, `"noImplicitAny": true`,
    `"strictNullChecks": true`.
  - Enable `"exactOptionalPropertyTypes": true`,
    `"noUncheckedIndexedAccess": true`.
  - Enable `"noImplicitReturns": true`, `"noFallthroughCasesInSwitch": true`.
- **Type Safety & Soundness:**
  - Prohibit `any` and unvalidated type assertions (`as Type` or
    `as unknown as Type`).
  - Use `unknown` for unvetted inputs; narrow types via custom type predicates
    (`val is Type`), assertion functions (`asserts val is Type`), or runtime
    validation libraries (e.g. Zod, ArkType).
  - Use branded or nominal types (`type UserId = string & { readonly __brand:`
    `unique symbol }`) to prevent primitive obsession.
  - Employ `satisfies` to validate expression types without widening literal
    types.
  - Leverage `const` type parameters (`<const T>`) and `as const` for literal
    inference.

## Functional Programming Foundations

- **Pure Core, Effectful Shell:** Separate pure business logic from effectful
  I/O operations. Confine side effects (network, filesystem, state mutation) to
  system boundaries and entrypoints.
- **Immutability by Default:**
  - Enforce immutability using `readonly` modifiers (`readonly T[]`,
    `Readonly<T>`, `ReadonlyMap<K, V>`).
  - Prohibit in-place array mutation (`push`, `pop`, `shift`, `splice`, `sort`).
  - Use non-mutating alternatives (`toSorted`, `toReversed`, `toSpliced`,
    `map`, `filter`, `concat`, array spread).
  - Use immutable object updates via object spread or lens/copy utilities.
- **Data Modelling with Algebraic Data Types:**
  - Model domain variants using discriminated unions with explicit tag fields
    (e.g. `{ readonly type: 'success'; readonly data: T }`).
  - Enforce exhaustive pattern matching on union variants using an exhaustive
    helper function (`assertNever(x: never): never`).
- **Error Handling as Data:**
  - Represent domain failures explicitly as data values using a `Result` or
    `Either` algebraic type (`type Result<T, E> = Ok<T> | Err<E>`) rather than
    throwing runtime exceptions.
  - Reserve exceptions strictly for unrecoverable infrastructure failures.
- **Composition & Higher-Order Functions:**
  - Compose pure functions with utilities such as `pipe` or `flow`.
  - Favour currying and partial application for composable predicate and
    transformation pipelines.

## Function Annotations & TSDoc Standards

- **Mandatory Documentation:** Every top-level and exported function must
  provide a complete TSDoc comment (`/** ... */`) immediately preceding its
  definition.
- **Required Annotation Elements:**
  - **Summary Description:** Clear explanation of function intent, behavioural
    characteristics (such as referential transparency or idempotency), and
    domain context.
  - **Parameter Tags (`@param`):** An explicit `@param` entry for each argument
    specifying its purpose, expected format, and value constraints.
  - **Return Tag (`@returns`):** Detailed description of returned values, data
    structures, and potential failure states.
  - **Generic Parameters (`@template`):** Explanation of type variables and
    their bounds.
  - **Examples (`@example`):** Concise, realistic code snippets demonstrating
    invocation patterns.
  - **Purity & Errors:** Explicitly state purity guarantees; document
    exceptional conditions with `@throws` when total failure modelling is not
    used.
- **Explicit Type Signatures:** Always include explicit parameter types and
  explicit return type annotations on all function signatures. Never rely on
  implicit return type inference for exported functions or public module
  boundaries (see [examples/patterns.md](./examples/patterns.md)).

## Testing & QuickCheck-Style Property Testing

- **Unit Testing:** Write fast, deterministic unit tests using Vitest (or Jest)
  under `tests/` or alongside source files. Follow the Arrange-Act-Assert (AAA)
  pattern.
- **Generative Property-Based Testing (`fast-check`):**
  - Implement QuickCheck-style property tests using `fast-check` to verify
    invariants across hundreds of generated pseudo-random inputs.
  - Structure property assertions with `fc.assert(fc.property(...))`.
  - Define custom domain arbitraries using `fc.record`, `fc.tuple`,
    `fc.integer`, `fc.string`, and filtering combinators.
- **Core Invariants to Verify:**
  - **Round-Trip (Isomorphism):** Serialisation and parsing symmetry
    (`parse(serialize(x)) === x`).
  - **Idempotence:** Repeated operations yield identical results
    (`f(f(x)) === f(x)`).
  - **Commutativity & Associativity:** Algebraic laws for binary operators
    (`f(a, b) === f(b, a)` and `f(f(a, b), c) === f(a, f(b, c))`).
  - **Invariant Preservation:** Validity constraints hold across state
    transitions.

## Build Orchestration & Makefile Tooling

- **Centralised Task Management:** Wrap all development, formatting, linting,
  building, and testing tasks in a root `Makefile` for consistent developer and
  CI workflows.
- **Standard Makefile Targets:**
  - `make format`: Auto-format code using Prettier or Biome.
  - `make lint`: Run static analysis via ESLint or Biome.
  - `make check`: Run type verification (`tsc --noEmit`) without emitting
    compiled output.
  - `make test`: Run test runner (Vitest or Jest) executing unit and property
    tests.
  - `make build`: Compile TypeScript and bundle distributables (`tsc`, `tsup`).
  - `make clean`: Remove build outputs (`dist/`, `build/`, `*.tsbuildinfo`).
- **Idiomatic Makefile Rules:**
  - Declare all action targets as `.PHONY`.
  - Configure `SHELL := bash` and `.SHELLFLAGS := -eu -o pipefail -c` for
    defensive error handling.
  - Provide a default `help` target parsing double-hash comments (`##`).
- **Reference Implementation:** See
  [examples/patterns.md](./examples/patterns.md) for a complete reference
  `Makefile`, TSDoc annotated function, and `fast-check` property test suite.

## Agent Development & Validation Workflow

- **Validation Loop:** Anchor development to the project lifecycle:
  `Understand → Plan → Modify → Make → Test → Review`.
- **Pre-Flight Validation:** Execute `make check` before running test suites to
  catch compiler errors rapidly.
- **Property Verification:** When modifying pure domain functions, always run
  `make test` to ensure generative property tests pass without counterexamples.
- **Scratch Files:** Store diagnostic scripts and one-off experiments in the
  session scratch directory (`tsx scratch/test.ts`).

## Review & Output Contract

Apply this output structure **only** when the user asks for a code review or
audit. For implementation or bug-fix tasks, apply edits directly, run
verification, and report concisely:

1. **Summary:** Architectural overview, functional design, and modularity.
2. **Type Safety & Soundness:** Compiler strictness, branded types, avoidance of
   `any` or unsafe assertions, and discriminated unions.
3. **Functional Architecture & Immutability:** Purity, side-effect containment,
   `readonly` usage, and non-mutating algorithms.
4. **TSDoc & Documentation:** Quality of function descriptions, `@param`,
   `@returns`, and explicit signature typing.
5. **Testing & Property Verification:** Unit test coverage and `fast-check`
   property tests for invariants.
6. **Tooling & Makefile:** Makefile target consistency and build configuration.
7. **Suggested Code / Diff:** Idiomatic, fully annotated TypeScript
   implementation.

## Cross-Skill References

- **`architecture-review`** — Pure core / effectful shell, polymorphic
  boundaries, and FP refactoring.
- **`requirements-review`** — Stress-test domain invariants and data models.
- **`makefile-programmer`** — Coordinate `Makefile` targets for builds and
  tests.
- **`markdown-editor`** — Format docstrings and markdown documentation.

## Resources

- Language: [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- Property Testing: [fast-check Documentation](https://fast-check.dev/)
- Documentation: [TSDoc Standard](https://tsdoc.org/)
- Functional TS: [Effect Documentation](https://effect.website/)
- Test Framework: [Vitest Documentation](https://vitest.dev/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
