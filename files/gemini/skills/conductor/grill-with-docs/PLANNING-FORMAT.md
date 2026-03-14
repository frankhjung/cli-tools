# Planning Format

Generic planning template for the `grill-with-docs` and `grill-me` skills. Keep
plans concise, decision-oriented, and free of implementation detail.

## Template

```md
# {Plan Title}

{One or two sentences describing the problem and why this plan exists.}

## Goals

- {What must be true when this work is complete.}

## Non-Goals

- {What is explicitly out of scope for this plan.}

## Assumptions and Constraints

- {Known facts, boundaries, and external limits.}

## Approach

{Brief high-level approach. Focus on shape and sequence, not implementation.}

## Risks and Mitigations

- **Risk**: {Potential issue}
  **Mitigation**: {How to reduce or detect it early}

## Tooling and Workflow

- **Branching**: {How Git branches should be named and used.}
- **Build tools**: {Primary build/automation entry points.}
- **Linting and formatting**: {Required quality checks before merge.}
- **Testing**: {How test execution fits into the workflow.}
- **Delivery flow**: {Typical order: branch, plan, implement, verify, review, merge.}

## Decisions

Record durable, non-obvious trade-offs made during planning here.

- Use the format in [DECISIONS-FORMAT.md](./DECISIONS-FORMAT.md).
- Store decision records in `docs/feature.md` as defined by that format.
- Add decisions only when they are hard to reverse, surprising without context,
  and involve a real trade-off.

## Open Questions

- {Questions that must be resolved before execution.}

## Success Criteria

- {Observable signals that the plan achieved its goals.}
```

## Guidance

- Keep each section short and concrete.
- Prefer bullets over long prose.
- Use project language consistently.
- Do not include implementation specifics.
