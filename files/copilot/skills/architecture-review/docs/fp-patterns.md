# Functional Programming Patterns

Architectural patterns expressed through FP idioms. This document maps the
vocabulary in [language.md](language.md) to concrete FP design patterns, ordered
by priority: Haskell first, then Clojure, then Python.

For language-specific coding standards, refer to:

- `haskell-programmer` — type safety, purity, HLint
- `clojure-programmer` — data orientation, protocols
- `python-programmer` — functional style, ruff, typing

## Pure Core, Effectful Shell

The foundational FP architectural pattern. All domain logic is pure; effects are
pushed to the boundary.

**Haskell**: Pure functions at the core. `IO` actions only in `Main` or a thin
shell. Use `ReaderT env IO` or similar for configuration. The type system
enforces the separation — if a function's type is pure, it cannot perform IO.

**Clojure**: Pure functions operating on immutable data structures at the core.
Side-effecting functions (marked with `!`) at the edges. Discipline replaces
compiler enforcement.

**Python**: Pure functions returning values, no mutation. IO and side effects
isolated in entry-point modules. Use `functools`, `itertools`, and
comprehensions instead of imperative loops.

### Core/Shell Leverage Implication

A pure core is inherently high-leverage: pass values in, assert on values out.
No mocks needed.

## State Management and Concurrency Boundaries

Managing state and asynchronous execution while keeping the domain core pure.

**Haskell**: Software Transactional Memory (`STM`), `TVar`, or `MVar` at the
effectful boundary. Pure transition functions compute next states, while `STM`
atomically applies mutations.

**Clojure**: Atoms, Refs, and Agents for identity/state separation. Pure
`swap!` functions calculate new states; Clojure handles thread synchronisation
at the boundary.

**Python**: Explicit state containers (e.g. `asyncio.Queue`, thread-safe state
objects). Pure functions compute state updates; async loops dispatch effects.

### State Boundary Leverage Implication

Isolating state mutation to explicit concurrency primitives keeps the bulk of
state transition logic completely pure, testable, and composable.

## Algebraic Data Types for Domain Modelling

Model your domain with sum types and product types, not class hierarchies.

**Haskell**: Use `data` declarations with constructors. Pattern match
exhaustively — the compiler warns on missing cases. Use `newtype` for semantic
wrappers.

```haskell
data OrderStatus
  = Pending
  | Confirmed ConfirmationId
  | Shipped TrackingNumber
  | Cancelled CancelReason
```

**Clojure**: Use tagged maps or keywords for sum-type equivalents. Validate
shapes with Malli schemas.

```clojure
{:status :pending}
{:status :confirmed :confirmation-id "abc-123"}
```

**Python**: Use `Union` (or `|` in Python 3.10+) of `frozen` `dataclasses` for
sum types, or `enum.Enum` for simple variants. Type hints express the domain.
Use `match` (Python 3.10+) for case handling. With strict static analysis
settings, some tools can warn on missing cases; otherwise test union case
coverage explicitly.

```python
@dataclass(frozen=True)
class Pending: pass

@dataclass(frozen=True)
class Shipped:
    tracking_number: str

OrderStatus = Pending | Shipped
```

### ADT Leverage Implication

ADTs make the domain explicit in the types. Low-leverage modules often use
strings or booleans where an ADT would add leverage.

## Typeclasses, Protocols, and Polymorphic Boundaries

Use typeclasses (Haskell), protocols (Clojure), or `Protocol` classes (Python)
to define **polymorphic boundaries** — points where behaviour varies.

**Haskell**: Define a typeclass for the capability. Instances are adapters.

```haskell
class Monad m => OrderRepo m where
  findOrder :: OrderId -> m (Maybe Order)
  saveOrder :: Order -> m ()
```

Production instance uses Postgres; test instance uses `IORef (Map OrderId
Order)`.

**Clojure**: Define a protocol. Implementations via `defrecord` or `reify`.

```clojure
(defprotocol OrderRepo
  (find-order [repo order-id])
  (save-order! [repo order]))
```

**Python**: Use `Protocol` (typing module) or abstract base classes. Pass
implementations as function arguments (dependency injection via higher-order
functions).

### Typeclass/Protocol Leverage Implication

A typeclass/protocol defines a polymorphic boundary. One adapter = hypothetical.
Two = real.

## Higher-Order Functions for Composition

Compose behaviour by passing functions, not by inheriting from base classes.

**Haskell**: Function composition (`(.)`), pipelines (`&`), `map`, `foldr`,
`traverse`. Point-free style when it improves clarity.

**Clojure**: Threading macros (`->`, `->>`), `map`, `filter`, `reduce`, `comp`,
`partial`.

**Python**: `map`, `filter`, `functools.reduce`, `functools.partial`,
comprehensions, `itertools`.

### Higher-Order Function Leverage Implication

Higher-order functions build high-leverage modules from composable pieces
without exposing composition in the interface.

## Referential Transparency and Testability

A referentially transparent function always returns the same output for the same
input, with no side effects. This is the foundation of testability in FP.

- **If it's pure, it's testable.** No setup, no mocks, no teardown. Pass values
  in, assert on values out.
- **If it's impure, isolate it.** Push the impurity to the boundary and test the
  pure core directly.
- **Property-based tests** work best on pure functions — generate random inputs
  and verify invariants hold.

See [tdd.md](tdd.md) for the TDD workflow that builds on this foundation.

## Effect Management

How different FP ecosystems handle effects at scale:

**Haskell**: `MTL`-style (`MonadReader`, `MonadError`), tagless final, or effect
systems (`effectful`, `polysemy`). Choose based on project complexity — `ReaderT
IO` is often sufficient.

**Clojure**: Component/Integrant for lifecycle management. Effects are functions
with `!` suffix. No type-level enforcement — rely on convention and testing.

**Python**: Dependency injection via function arguments. No effect system — use
pure functions and push IO to `main()`. Type hints document effectful
boundaries.

### Effect Management Leverage Implication

Effect management determines where polymorphic boundaries live. A well-chosen
strategy keeps the core pure and high-leverage.
