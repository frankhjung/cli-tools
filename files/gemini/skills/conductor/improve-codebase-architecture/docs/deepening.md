# Deepening

How to deepen a cluster of shallow modules safely, given its dependencies.
Assumes the vocabulary in [language.md](language.md) — **module**,
**interface**, **seam**, **port**, **adapter**.

## Dependency Categories

When assessing a candidate for deepening, classify its dependencies. The
category determines how the deepened module is tested across its seam.

### 1. In-process (Pure)

Pure computation, in-memory state, no IO. Always deepenable — merge the modules
and test through the new interface directly. No adapter needed. In Haskell,
these are pure functions; in Clojure, pure functions operating on immutable
data.

### 2. Local-substitutable

Dependencies that have local test stand-ins (e.g. in-memory database, temporary
filesystem). Deepenable if the stand-in exists. The deepened module is tested
with the stand-in running in the test suite. The seam is internal; no port at
the module's external interface.

### 3. Remote but Owned (Ports and Adapters)

Your own services across a network boundary. Define a **port** (typeclass in
Haskell, protocol in Clojure) at the seam. The deep module owns the logic; the
transport is injected as an **adapter** (typeclass instance or `reify`). Tests
use an in-memory adapter. Production uses an HTTP/gRPC/queue adapter.

Recommendation shape: _"Define a typeclass at the seam, implement an HTTP
instance for production and an in-memory instance for testing, so the logic sits
in one deep module even though it's deployed across a network."_

### 4. True External (Mock)

Third-party services you don't control. The deepened module takes the external
dependency as an injected port; tests provide a mock adapter.

## Seam Discipline

- **One adapter means a hypothetical seam. Two adapters means a real one.**
  Don't introduce a port unless at least two adapters are justified (typically
  production and test). A single-adapter seam is just indirection.
- **Internal seams vs external seams.** A deep module can have internal seams
  (private to its implementation, used by its own tests) as well as the external
  seam at its interface. Don't expose internal seams through the interface just
  because tests use them.

## Testing Strategy: TDD at the Interface

Follow a strict test-driven workflow when deepening:

1. **Red** — Write a failing test at the deepened module's intended interface
   _before_ writing any implementation. See [tdd.md](tdd.md) for details.
2. **Green** — Write the minimum implementation to pass.
3. **Refactor** — Deepen the module, keeping tests green.

Key principles:

- Old unit tests on shallow modules become waste once tests at the deepened
  module's interface exist — delete them.
- Write new tests at the deepened module's interface. The **interface is the
  test surface**.
- Tests assert on observable outcomes through the interface, not internal state.
- Tests should survive internal refactors — they describe behaviour, not
  implementation. If a test must change when the implementation changes, it's
  testing past the interface.
- For pure functions, prefer property-based tests (QuickCheck, test.check,
  Hypothesis) over example- based tests where feasible.
