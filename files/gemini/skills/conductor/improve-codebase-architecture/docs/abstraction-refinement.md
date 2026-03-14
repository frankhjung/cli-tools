# Abstraction Refinement

How to refine a cluster of low-leverage modules safely, given their
dependencies. Assumes the vocabulary in [language.md](language.md).

## Dependency Categories

Classify dependencies to determine testing strategy across the polymorphic
boundary.

### 1. In-process (Pure)

Pure computation, no IO. Always refinable — merge and test through the new
interface directly. No adapter needed.

### 2. Local-substitutable

Dependencies with local test stand-ins (e.g. in-memory database, temporary
filesystem). Refinable if the stand-in exists. The boundary is internal; no
capability interface at the module's external interface.

### 3. Remote but Owned

Your own services across a network boundary. Define a **capability interface**
(typeclass / protocol / `Protocol`) at the polymorphic boundary. Inject
transport as an **adapter**. Tests use an in-memory adapter; production uses
HTTP/gRPC/queue.

### 4. True External (Mock)

Third-party systems you do not control. Inject the dependency as a capability
interface; tests provide a mock adapter.

## Boundary Discipline

- **One adapter = hypothetical. Two = real.** Do not introduce a capability
  interface unless at least two adapters are justified (typically production +
  test).
- **Internal vs external boundaries.** A refined module can have internal
  boundaries (private, used by its own tests) as well as the external
  polymorphic boundary. Do not expose internal boundaries through the interface
  just because tests use them.

## Testing

Follow the TDD workflow in [tdd.md](tdd.md).
