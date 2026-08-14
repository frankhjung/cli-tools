---
name: requirements-review
description: >-
  Conduct interactive requirements elicitation and stress-test plans or
  designs. Explores edge cases, sharpens domain terms, enforces invariants,
  and updates GLOSSARY.md and architecture records.
---

Guide requirements elicitation through rigorous, step-by-step architectural
inquiry until complete alignment on design, scope, and domain models is reached.

## Interview Workflow & Rules

1. **Inspect Before Asking:** Explore the codebase and existing documentation
   first; never ask questions that the code already answers.
2. **One Question at a Time:** Ask targeted questions sequentially down the
   decision tree. For every question, provide a recommended answer with clear
   reasoning.
3. **Sharpen Fuzzy Terms:** Propose canonical domain terminology when
   ambiguous language arises (e.g. distinguishing User vs Customer vs Account).
4. **Concrete Edge Cases:** Test boundaries with realistic failure scenarios
   and state transitions.

## Grilling Dimensions

Stress-test requirements across these core dimensions:

- **Scope & Non-Goals:** Explicit boundaries of what will *not* be built.
- **State & Invariants:** Forbidden transitions, constraints, and data shapes.
- **Failure Modes & Degradation:** Behaviour when downstream services or
  dependencies fail.
- **Data Ownership:** Which domain component owns specific fields and schemas.
- **Concurrency & Ordering:** Simultaneous operations and race conditions.

## Glossary & Architecture Documentation

- **Glossary Checks:** Challenge terms against local and root `GLOSSARY.md`
  files. Surface contradictions immediately.
- **Inline Glossary Updates:** When a domain concept is defined, update the
  relevant `GLOSSARY.md` immediately using the format defined in
  [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md). Keep it devoid of implementation
  details.
- **Architecture Decisions:** When a load-bearing trade-off is resolved, offer
  to record a decision note in `docs/REQ-NNN-slug.md`.

## Session Conclusion

Upon concluding the review:

1. Update the primary implementation plan or design document to reflect all
   settled decisions.
2. Summarise new or refined terms recorded in `GLOSSARY.md`.
3. Create any requested architectural requirement notes
   (`docs/REQ-NNN-slug.md`).
