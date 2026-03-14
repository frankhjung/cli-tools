# DECISIONS Format

Decision records live in `docs/feature.md` as sub-headings and use sequential
numbering: `0001-slug`, `0002-slug`, etc.

Update the `docs/feature.md` file lazily - only when the first decision record
is needed.

## Template

```md
## {Short title of the decision}

{1-3 sentences: what's the context, what did we decide, and why.}
```

That is it. A decision record can be a single paragraph. The value is in
recording that a decision was made and why, not in filling out sections.

## Optional sections

Only include these when they add genuine value. Most decision records will not
need them.

- **Status** frontmatter
  (`proposed | accepted | deprecated | superseded by DECISIONS-NNNN`) - useful
  when decisions are revisited
- **Considered Options** - only when the rejected alternatives are worth
  remembering
- **Consequences** - only when non-obvious downstream effects need to be called
  out

## Numbering

Scan `docs/feature.md` for the highest existing number and increment by one.

## When to offer a decision record

All three of these must be true:

1. **Hard to reverse** - the cost of changing your mind later is meaningful
2. **Surprising without context** - a future reader will look at the code and
   wonder "why on earth did they do it this way?"
3. **The result of a real trade-off** - there were genuine alternatives and you
   picked one for specific reasons

If a decision is easy to reverse, skip it. If it is not surprising, nobody will
wonder why. If there was no real alternative, there is nothing to record beyond
"we did the obvious thing".

### What qualifies

- **Architectural shape.** "We're using a monorepo." "The write model is
  event-sourced, the read model is projected into Postgres."
- **Integration patterns between contexts.** "Ordering and Billing communicate
  via domain events, not synchronous HTTP."
- **Technology choices that carry lock-in.** Database, message bus, auth
  provider, deployment target. Not every library, just the ones that would take
  a quarter to swap out.
- **Boundary and scope decisions.** "Customer data is owned by the Customer
  context; other contexts reference it by ID only." The explicit no values are
  as useful as the yes values.
- **Deliberate deviations from the obvious path.** "We use manual SQL instead of
  an ORM because X." Anything where a reasonable reader would assume the
  opposite.
- **Constraints not visible in the code.** "We cannot use AWS because of
  compliance requirements." "Response times must be under 200ms because of the
  partner API contract."
- **Rejected alternatives when the rejection is non-obvious.** If you considered
  GraphQL and picked REST for subtle reasons, record it; otherwise someone will
  suggest GraphQL again in six months.
