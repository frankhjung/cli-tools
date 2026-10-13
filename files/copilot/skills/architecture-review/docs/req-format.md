# REQ: Requirements Document Format

Architectural requirements live in `docs/` and use sequential numbering with a
descriptive slug: `REQ-001-slug.md`, `REQ-002-slug.md`, etc.

The **slug** is a short, lowercase, hyphen-separated label derived from the
decision's subject — the same convention used in Git branch names and issue
trackers. For example: `REQ-003-event-sourced-write-model.md` or
`REQ-007-no-orm.md`. Keep slugs under five words.

Create the `docs/` directory lazily — only when the first requirement is needed.

## Template

```md
---
status: proposed | accepted | deprecated | superseded by REQ-NNN-slug
---

# {Short title of the decision}

{1–3 sentences: what's the context, what did we decide,
and why.}
```

That's it. A requirement can be a single paragraph. The value is in recording
_that_ a decision was made and _why_ — not in filling out sections.

## Status Lifecycle and Supersession

Requirements evolve as architectural context changes. Maintain decision
history explicitly:

- **proposed:** Under discussion during architecture review or grilling.
- **accepted:** Decision agreed upon and currently active in the codebase.
- **deprecated:** Decision no longer applies or recommended, but not explicitly
  replaced by a single new REQ.
- **superseded by REQ-NNN-slug:** Decision replaced by a newer REQ. Update the
  old REQ header to link to the new document.

## Optional Sections

Only include these when they add genuine value. Most requirements will not need
them.

- **Considered Options** — only when the rejected alternatives are worth
  remembering
- **Consequences** — only when non-obvious downstream effects need to be called
  out

## Numbering

Scan `docs/` for the highest existing number and increment by one.

## When to Offer a REQ

All three of these must be true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will look at the code and
   wonder "why on earth did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you
   picked one for specific reasons

## What Qualifies

- **Architectural shape.** "We are using a monorepo." "The write model is
  event-sourced, the read model is projected into Postgres."
- **FP design choices.** "We chose tagless final over free monads because…"
  "Domain logic is pure; all IO is in `Main`."
- **Integration patterns between contexts.** "Ordering and Billing communicate
  via domain events, not synchronous HTTP."
- **Technology choices that carry lock-in.** Database, message bus, auth
  provider, deployment target. Not every library — just the ones that would take
  a quarter to swap out.
- **Scope decisions.** "Customer data is owned by the Customer context; other
  contexts reference it by ID only." The explicit no's are as valuable as the
  yes's.
- **Deliberate deviations from the obvious path.** "We are using raw SQL instead
  of an ORM because X." Anything where a reasonable reader would assume the
  opposite.
- **Constraints not visible in the code.** "We cannot use AWS because of
  compliance requirements."
- **Rejected alternatives when the rejection is non-obvious.** If you considered
  a free monad and picked `ReaderT IO` for subtle reasons, record it.
