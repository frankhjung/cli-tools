# Language

Shared vocabulary for every suggestion this skill makes. Use these terms exactly
— do not substitute "component," "service," or "API." Use "boundary" only in
"push effects to the boundary"; for architecture terms, say **polymorphic
boundary**, **capability interface**, or **interface**.

## Terms

**Module** — Anything with an interface and an implementation. Scale-agnostic: a
Haskell module, a Clojure namespace, a Python module, a single function, or a
tier-spanning slice. _Avoid_: unit, component, service.

**Interface** — Everything a caller must know to use the module correctly.
**Contract** is an approved synonym. _Avoid_: API, signature (too narrow — those
refer only to the type-level surface).

**Implementation** — The body of code inside a module. Reach for "adapter" when
the polymorphic boundary is the topic; "implementation" otherwise.

**Leverage** (Ousterhout's "depth") — How much behaviour a caller can exercise
per unit of interface they must learn. **High-leverage** = large behaviour behind
a small interface. **Low-leverage** = interface nearly as complex as the
implementation (leaky abstraction).

**Polymorphic Boundary** — Where behaviour varies polymorphically without
editing code at that site. In Haskell: a typeclass constraint. In Clojure: a
protocol. In Python: a `Protocol` or abstract base class.

**Capability Interface** (aka **Port**) — A named set of operations the module
requires from the outside world. States required capabilities, not transport or
storage.

**Adapter** — A concrete thing that satisfies a capability interface at a
polymorphic boundary. In Haskell: a typeclass instance. In Clojure: `reify` or
`defrecord`. In Python: a concrete class implementing a `Protocol`. Describes
_role_, not substance.

**Locality** — The maintainer-facing consequence of high leverage: change
concentrates in one place. One implementation pays back across N call sites and
M tests.

## FP Mappings

- **Module**: Haskell module / Clojure namespace / Python module or package
- **Interface**: Typeclass + laws / Protocol + specs / `Protocol` + docstring
- **Polymorphic Boundary** (the _site_ where behaviour varies): Typeclass
  constraint / Protocol / `Protocol` or ABC
- **Capability Interface** (the _specification_ at that site): Typeclass /
  Protocol / `Protocol` or ABC
- **Adapter**: Instance / `reify` or `defrecord` / Concrete implementation
- **Pure core**: Pure functions (all three)
- **Effectful shell**: `IO` or `MonadIO` / Side-effecting functions / `main()`
  or entry points

## Principles

- **Leverage is a property of the interface, not the implementation.** Internal
  composition stays private.
- **The deletion test.** If complexity reappears across N callers when you
  delete the module, it earns its keep.
- **The interface is the test surface.** Callers and tests cross the same
  polymorphic boundary.
- **One adapter = hypothetical. Two = real.** Do not introduce a capability
  interface unless something varies across it.
- **Pure core, effectful shell.** Effects belong at the edges; core logic is
  pure, composable, testable.

## Relationships

- A **Module** should expose one coherent **Interface** (which may include
  multiple operations).
- **Leverage** is measured against the **Interface**.
- A **Polymorphic Boundary** is a site where an **Interface** admits multiple
  **Adapters**.
- A **Capability Interface** is an **Interface** at a **Polymorphic Boundary**
  for external capabilities.
- An **Adapter** sits at a **Polymorphic Boundary** and satisfies the
  **Interface**.
- High **Leverage** produces **Locality**.

## Rejected Framings

- **Leverage as implementation-to-interface line ratio** (Ousterhout's original
  formulation): rewards padding. We measure leverage by behaviour per unit of
  interface.
- **"Interface" as typeclass or public methods**: too narrow — includes laws,
  invariants, ordering constraints.
- **"Boundary" as architecture term**: overloaded with DDD. Say **polymorphic
  boundary** or **interface**. The FP phrase "effects at the boundary" remains
  valid.
