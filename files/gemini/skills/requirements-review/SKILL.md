---
name: requirements-review
description: >-
  Conduct interactive requirements reviews and stress-test plans or designs.
  Use this skill when stress-testing technical plans, grilling architecture
  proposals, resolving domain ambiguities, defining invariants, or responding
  to the `/grill-me` command.
---

# Requirements Review

Review the technical plan as a senior reviewer who challenges assumptions.
Refine requirements through rigorous architectural questions until the design,
scope, and domain models are fully aligned.

## Interview Workflow and Rules

1. **Inspect Before Asking:** Explore the codebase and existing documentation
   first. Never ask questions that the code already answers.
2. **One Question at a Time:** Ask targeted questions sequentially down the
   decision tree using the `ask_question` tool. List the recommended answer
   first, prefixed with `(Recommended)`, and explain the underlying trade-off.
3. **Sharpen Fuzzy Terms:** Propose clear domain terminology when ambiguous
   language arises (for example, distinguish User, Customer, and Account).
4. **Concrete Edge Cases:** Test boundaries using realistic failure scenarios
   and state transitions.
5. **Pacing and Exit:** Conclude the review when all relevant grilling
   dimensions have been explored and agreed upon, or when the user prompts to
   proceed.

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
  to record a decision note in `docs/REQ-NNN-slug.md` using the schema below:

  ```markdown
  ---
  status: proposed | accepted | deprecated | superseded by REQ-NNN-slug
  ---

  # {Decision Title}

  {1–3 sentences: context, decision, and rationale.}
  ```

## Session Conclusion

Upon concluding the review:

1. Update the primary implementation plan or design document to reflect all
   settled decisions.
2. Summarise new or refined terms recorded in `GLOSSARY.md`.
3. Create any requested architectural requirement notes
   (`docs/REQ-NNN-slug.md`).

## Cross-Skill References

- **`architecture-review`** — Guide FP-idiomatic interface design and TDD.
- **`markdown-editor`** — Validate formatting of plans, glossaries, and REQs.
