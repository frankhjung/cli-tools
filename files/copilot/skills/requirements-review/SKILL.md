---
name: requirements-review
description: >-
  Conduct interactive requirements reviews and stress-test plans or designs.
  Explore edge cases, define clear domain terms, enforce invariants, and
  update GLOSSARY.md and architecture records.
---

Review the technical plan as a senior reviewer who challenges assumptions.
Refine requirements through rigorous architectural questions until the design,
scope, and domain models are fully aligned.

## Interview Workflow and Rules

1. **Inspect Before Asking:** Explore the codebase and existing documentation
   first. Never ask questions that the code already answers.
2. **One Question at a Time:** Ask targeted questions sequentially down the
   decision tree. For every question, provide a recommended answer with clear
   reasoning.
3. **Sharpen Fuzzy Terms:** Propose clear domain terminology when ambiguous
   language arises (for example, distinguish User, Customer, and Account).
4. **Concrete Edge Cases:** Test boundaries using realistic failure scenarios
   and state transitions.

## Grilling Dimensions

Stress-test requirements across these core dimensions:

- **Scope and Non-Goals:** Define explicit boundaries of what will *not* be
  built.
- **State and Invariants:** Identify forbidden transitions, constraints, and
  data shapes.
- **Failure Modes and Degradation:** Define system behaviour when downstream
  services or dependencies fail.
- **Data Ownership:** Identify which domain component owns specific fields and
  schemas.
- **Concurrency and Ordering:** Address simultaneous operations and potential
  race conditions.

## Glossary and Architecture Documentation

- **Glossary Checks:** Challenge terms against local and root `GLOSSARY.md`
  files. Surface any contradictions immediately.
- **Inline Glossary Updates:** When a domain concept is defined, immediately
  update the relevant `GLOSSARY.md` file using the format defined in
  [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md). Do not include implementation
  details.
- **Architecture Decisions:** When a significant trade-off is resolved, offer
  to record a decision note in `docs/REQ-NNN-slug.md`.

## Session Conclusion

Upon concluding the review:

1. Update the primary implementation plan or design document to reflect all
   settled decisions.
2. Summarise new or refined terms recorded in `GLOSSARY.md`.
3. Create any requested architectural requirement notes
   (`docs/REQ-NNN-slug.md`).
