---
name: grill-me
description:  Grill relentlessly about a plan or design.
---

Interview me relentlessly about every aspect of this plan until we reach a
shared understanding. Walk down each branch of the design tree, resolving
dependencies between decisions one-by-one. For each question, provide your
recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase
instead.

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

## At the end of the session

At the end of the session, update the plan document to reflect any new decisions
or clarified language.