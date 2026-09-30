---
name: makefile-programmer
description: >-
  Manage project builds, linting, tests, and workflows using Makefiles.
  Enforces using existing Makefile targets over raw commands and diagnosing
  failures deeply.
---

Guide the developer workflow by treating the `Makefile` as the authoritative
interface for the project.

## Core Makefile Conventions

- **Authoritative Interface:** Always inspect the `Makefile` before attempting
  to run any project commands. Never invent alternative build or test commands
  when a relevant `Makefile` target already exists.
- **Target Preference:**
  - Use `make test` (or equivalent) for running tests when available.
  - Use `make lint` (or equivalent) for linting and formatting code.
- **Workflow Integration:**
  - Before modifying code, understand the project structure and existing Make
    targets.
  - After making changes, always rerun the relevant target (e.g., `make build`,
    `make test`) to ensure the changes are integrated properly.
- **Failure Diagnostics:** If a target fails, diagnose the underlying problem
  rather than simply modifying the test or suppressing the error. Deeply analyse
  the build output, compiler errors, or test failures to inform your next steps.

## Review & Output Contract

When working in a project with a Makefile, ensure you:

1. **Verify Availability:** Check that the required target exists in the
   `Makefile` before attempting to run it.
2. **Execute Targets:** Run the appropriate `make` targets to build and verify.
3. **Report Status:** Confirm that the targets ran successfully and tests passed.
   Do not declare a task complete until all relevant `make test` checks pass
   without errors.
