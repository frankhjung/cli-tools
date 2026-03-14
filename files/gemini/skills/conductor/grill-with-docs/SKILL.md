---
name: grill-with-docs
description: Grill a design or plan against documentation and prior decisions.
---

Interview me relentlessly about every aspect of this plan until we reach a
shared understanding. Walk down each branch of the design tree, resolving
dependencies between decisions one-by-one. For each question, provide your
recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase
instead.

During codebase exploration, also look for existing documentation.

## Domain awareness

### File structure

Most repos have a single context:

```text
/
├── GLOSSARY.md
├── docs/
│   └── feature.md
└── src/
```

If local glossaries exist, treat the root glossary as global and local
glossaries as refinements. The root glossary is always the source of truth.

Multi-context repos may include a `GLOSSARY-MAP.md` that points to context
locations.

Example structure:

```text
/
├── GLOSSARY.md
├── GLOSSARY-MAP.md
├── docs/
│   └── feature.md                    ← system-wide features
├── src/
│   ├── ordering/
│   │   ├── GLOSSARY.md
│   │   └── docs/feature.md           ← context-specific features
│   └── billing/
│       ├── GLOSSARY.md
│       └── docs/feature.md           ← context-specific features
```

Create files lazily - only when you have something to write. If no root
`GLOSSARY.md` exists, create it when the first root-level term is resolved. If
an area needs local language and no local `GLOSSARY.md` exists, create it when
the first local term is resolved. If no `docs/feature.md` exists, create it when
the first feature is documented.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in
`GLOSSARY.md`, call it out immediately. "Your glossary defines 'cancellation' as
X, but you seem to mean Y - which is it?"

If both root and local glossaries exist, challenge terms against the local one
first, then verify it does not conflict with the root.

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term.
"You are saying 'account' - do you mean Customer or User? Those are different
things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific
scenarios. Invent scenarios that probe edge cases and force the user to be
precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you
find a contradiction, surface it: "Your code cancels entire Orders, but you just
said partial cancellation is possible - which is right?"

### Update GLOSSARY.md inline

When a term is resolved, update the correct `GLOSSARY.md` right there. Do not
batch these up; capture them as they happen. Use the format in
[GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md).

`GLOSSARY.md` should be totally devoid of implementation details. Do not treat
it as a spec, a scratch pad, or a repository for implementation decisions. It is
a glossary and nothing else.

### Offer decision records sparingly

Only offer to create a decision record when all three are true:

1. **Hard to reverse** - the cost of changing your mind later is meaningful
2. **Surprising without context** - a future reader will wonder "why did they do
   it this way?"
3. **The result of a real trade-off** - there were genuine alternatives and you
   picked one for specific reasons

If any of the three is missing, skip the decision record. Use the format in
[DECISIONS-FORMAT.md](./DECISIONS-FORMAT.md).

## At the end of the session

At the end of the session, update the plan document in `docs/feature.md` to
reflect any new decisions or clarified language. If the plan changed
significantly, update the relevant sections in the plan template as well.

Use the format in [PLANNING-FORMAT.md](./PLANNING-FORMAT.md) for the plan
document.
