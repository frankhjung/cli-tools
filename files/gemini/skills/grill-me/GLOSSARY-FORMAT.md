# GLOSSARY.md Format

Instructions for building and maintaining a project's `GLOSSARY.md` — the domain
language that informs architectural decisions.

## Purpose

Every project should have a `GLOSSARY.md` at its root (or in `docs/`) that
defines the domain terms used in code, documentation, and conversation. This
file is the single source of truth for "what we call things."

The `improve-codebase-architecture` skill reads `GLOSSARY.md` to:

- Name abstraction refinement candidates using domain vocabulary
- Ensure suggestions use the project's language, not generic terms
- Identify when a new concept needs a name

## Template

```md
# Glossary

## {Term}

{1–3 sentences defining the term in the project's domain. Include what it is,
what it is not, and any important distinctions.}

_Avoid_: {synonyms to avoid}
```

The `_Avoid_` line is optional. Include it when a common synonym would cause
confusion.

## Rules

- **One term per heading.** Use H2 for each term.
- **Alphabetical order.** Sort terms alphabetically for easy scanning.
- **Domain terms only.** Do not define general programming terms (e.g.
  "function," "variable"). Define terms specific to this project's domain.
- **Plain language.** Write definitions a new team member could understand
  without prior context.
- **Include non-obvious distinctions.** If two terms are easily confused,
  clarify the difference explicitly.
- **Use Australian English** for all text content.
- **Respect the 80-column limit.**

## When to Update

- **During abstraction refinement** — if you name a refined module after a
  concept not yet in `GLOSSARY.md`, add it.
- **During grilling** — if conversation sharpens a fuzzy term, update
  `GLOSSARY.md` right there.
- **During onboarding** — if a new contributor asks "what does X mean?", that's
  a signal to add or clarify X.

## Example

```md
# Glossary

## Encounter

A single interaction between a patient and a healthcare provider at a specific
date and location. Not the same as a Visit (which may span multiple Encounters
across departments).

## Visit

A logical grouping of one or more Encounters under a single admission or
appointment. A Visit has exactly one primary provider and one billing context.
```

## Validation

Use the `markdown-validator` skill to ensure `GLOSSARY.md` conforms to markdown
standards.
