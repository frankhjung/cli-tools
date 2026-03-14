# Interface Design

When exploring alternative interfaces for a chosen refinement candidate, use the
"Design It Twice" principle (after Ousterhout).

Uses the vocabulary in [language.md](language.md) — **module**, **interface**,
**polymorphic boundary**, **capability interface**, **adapter**, **leverage**.

## Process

### 1. Frame the Problem Space

Before designing alternatives, write a clear explanation of the problem space
for the chosen candidate:

- The constraints any new interface must satisfy
- The dependencies it relies on, and which category they fall into (see
  [abstraction-refinement.md](abstraction-refinement.md))
- A rough illustrative code sketch to ground the constraints — not a proposal,
  just a way to make the constraints concrete

### 2. Design Alternatives

Produce at least three **radically different** interface designs for the refined
module. Frame each through an FP lens:

- **Minimal typeclass/protocol** — 1–3 methods max. Maximise leverage per
  method. Think `Functor` or `Foldable` in Haskell, or a `Protocol` with 1–2
  methods in Python.
- **Rich typeclass/protocol** — many methods, supporting many use cases and
  extension. Think `MonadIO` in Haskell, a Clojure protocol with several
  arities, or a rich `Protocol` or abstract base class in Python.
- **Data-oriented** — plain algebraic data types (Haskell), plain maps
  (Clojure), or frozen `dataclasses` (Python) with functions operating on them.
  No typeclass/protocol at all; the "interface" is the data shape.
- **Free monad / tagless final** (if applicable) — describe effects as data,
  interpret later. Maximises testability at the cost of complexity. This is
  primarily Haskell-centric. In Clojure, use data-as-effects via interpreters.
  This is rarely idiomatic in Python.

For each design, document:

1. Interface — types, methods, params, plus invariants, laws, error modes
2. Usage example showing how callers use it
3. What the implementation hides behind the polymorphic boundary
4. Dependency strategy and adapters (see
   [abstraction-refinement.md](abstraction-refinement.md))
5. Trade-offs — where leverage is high, where thin

Then validate against [FP Patterns](fp-patterns.md) and use `grill-me` to
resolve ambiguities.

### 3. Compare and Recommend

Compare designs by **leverage** (at the interface), **locality** (where change
concentrates), and **boundary placement**.

Give your own recommendation: which design is strongest and why. If elements
from different designs combine well, propose a hybrid. Be opinionated — the user
wants a strong read, not a menu.

Use `grill-me` to stress-test the chosen design with the user before committing.
