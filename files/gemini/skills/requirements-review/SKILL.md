---
name: requirements-review
description: Grill relentlessly about a plan or design.
---

# Requirements Review

Interview the user relentlessly about every aspect of a plan or design until a
shared architectural understanding is reached. Walk down each branch of the
design tree, resolving dependencies between decisions step-by-step. For each
question, provide a recommended answer.

Ask questions one at a time. If a question can be answered by inspecting the
codebase, explore the codebase first before asking.

## During the Session

### Grilling Checklist

Stress-test requirements across these key dimensions:

1. **Scope and Non-Goals:** What is explicitly out of scope for this change?
2. **State and Invariants:** What state transitions or data shapes are
   forbidden?
3. **Failure Modes:** How does the system degrade when downstream dependencies
   fail?
4. **Data Ownership:** Which domain module owns each entity and field?
5. **Concurrency:** What happens if two operations occur simultaneously?

### Challenge Against the Glossary

When the user uses a term that conflicts with language in `GLOSSARY.md`, call
it out immediately: *"Your glossary defines 'cancellation' as X, but you seem to
mean Y — which is it?"*

If both root and local glossaries exist, challenge terms against the local
glossary first, then verify it does not conflict with the root glossary.

### Sharpen Fuzzy Language

When vague or overloaded terms arise, propose a precise canonical term:
*"You are saying 'account' — do you mean Customer or User? Those represent
distinct domain concepts."*

### Discuss Concrete Scenarios

Stress-test domain relationships with concrete scenarios. Invent edge cases that
force precision around conceptual boundaries.

### Cross-Reference with Code

Verify whether code matches stated requirements. Surface contradictions:
*"The codebase cancels entire Orders, but you stated partial cancellation is
possible — which behaviour is required?"*

### Update `GLOSSARY.md` Inline

When a domain term is resolved, update the relevant `GLOSSARY.md` immediately. Do
not batch definitions up. Use the format defined in
[GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md).

Keep `GLOSSARY.md` devoid of implementation details; it is a domain glossary
and nothing else.

### Prompt for REQ Documents

When a load-bearing architectural decision or trade-off is resolved, offer to
record a requirement document:
*"Should I record this decision in `docs/REQ-NNN-slug.md`?"*

## At the End of the Session

At the conclusion of the review session:

1. Update the primary plan document to reflect all clarified requirements and
   agreed decisions.
2. Summarise any newly added or refined terms in `GLOSSARY.md`.
3. Create requested `docs/REQ-NNN-slug.md` files for load-bearing architectural
   trade-offs.
