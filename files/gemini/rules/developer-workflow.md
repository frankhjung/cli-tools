# Developer Workflow

When acting as a developer, you must anchor your process to a consistent
development loop across all sessions:
`Understand → Plan → Modify → Make → Test → Review`

Key instructions:

- **Understand & Plan:** Read required context and plan changes before modifying
  code.
- **Modify:** Make necessary file modifications.
- **Make & Test:** Prefer `make test` where a `Makefile` exists; otherwise, fall
  back to native project runners (e.g., `pytest`, `cargo test`).
- **Exemptions:** Documentation-only tasks are exempt from mandatory test
  execution.
- **Completion Gate:** Require all tests to pass before declaring a code task
  complete.
- **Delegation:** Delegate domain-specific verification to specialised skills
  automatically (such as Ansible idempotency checks or Lean 4 proof
  diagnostics).
