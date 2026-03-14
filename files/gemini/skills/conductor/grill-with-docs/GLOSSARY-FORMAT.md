# GLOSSARY.md Format

## Template

```md
# Glossary

## {Term}

{1–2 sentences: what it is, what it is not, and how it differs from similar
terms.}

_Avoid_: {synonyms to avoid}
```

The `_Avoid_` line is optional. Include it when a common synonym would cause
confusion.

## Rules

- **One term per heading.** Use H2 for each term.
- **Alphabetical order.** Sort terms alphabetically for easy scanning.
- **Domain terms only.** Define terms specific to this project. General
  programming concepts do not belong.
- **Plain language.** Write definitions a new team member could understand.
- **Be opinionated.** When multiple words exist for the same concept, pick the
  best one and list the rest under `_Avoid_`.
- **Flag ambiguities.** If a term is used inconsistently, call it out with a
  clear resolution.
- **Australian English** for all text content.
- **80-column limit.**

## Glossary hierarchy

**Root glossary:** One `GLOSSARY.md` at the repository root. Always canonical.

**Local glossary (optional):** A `GLOSSARY.md` inside a specific path when that
area needs extra vocabulary.

**Precedence rule:** Use the local glossary first, then verify it does not
conflict with the root.

## Multi-scope repos

For most repos one root `GLOSSARY.md` is enough.

When areas need local vocabulary, a `GLOSSARY-MAP.md` at the repo root lists
them and how they relate.

```md
# Glossary Map

## Local Glossaries

- [Ordering](./src/ordering/GLOSSARY.md) — receives and tracks customer orders
- [Billing](./src/billing/GLOSSARY.md) — generates invoices and processes
  payments
- [Fulfillment](./src/fulfillment/GLOSSARY.md) — manages warehouse picking and
  shipping
```

Resolution:

- If `GLOSSARY-MAP.md` exists, read it to find local glossaries.
- If only a root `GLOSSARY.md` exists, use that as canonical.
- If neither exists, create a root `GLOSSARY.md` lazily.

When multiple local glossaries exist, infer which one applies. If unclear, ask
