---
name: makefile-programmer
description: >-
  Develop, refactor, lint, and review GNU Makefiles (Makefile, GNUmakefile,
  *.mk), and manage project workflows via Make. Use this skill when authoring
  or modifying Makefiles, discovering targets, executing build and test
  workflows, or diagnosing recipe failures. Enforces GNU Make idioms, .PHONY
  declarations, robust shell flags, and self-documenting targets.
---

# Makefile Programmer

Guide Makefile development, refactoring, and execution workflows, treating
the `Makefile` as the authoritative project interface while enforcing robust
GNU Make idioms and defensive recipe execution.

## Target Execution & Workflow Discipline

- **Authoritative Interface:** Always inspect the `Makefile` before attempting
  to run build, test, or lint commands. Never invent alternative ad-hoc shell
  commands when a relevant target already exists.
- **Target Preference:**
  - Execute `make test` (or equivalent) for test suites.
  - Execute `make lint` or `make check` for linters and formatters.
- **Development Cycle:** Re-run verification targets immediately after code
  modifications to ensure integration integrity before completing tasks.
- **Deep Failure Diagnostics:** When a target fails, analyse compiler output,
  stack traces, or recipe exit codes. Fix underlying causes rather than
  suppressing errors or altering tests.
- **Non-Destructive Inspection:**
  - Preview recipe commands without execution: `make -n <target>`.
  - Introspect defined targets and variables: `make -qp`.
  - Diagnose prerequisite evaluation: `make -d <target>`.

## Makefile Authoring & Core Idioms

- **Recipe Indentation:** Strictly indent recipe lines with a single tab
  character (`\t`), never spaces.
- **Variable Assignments:**
  - `:=` (Simple expansion): Evaluate immediately at definition time. Use for
    constants, tool paths, and flags.
  - `=` (Recursive expansion): Evaluate lazily at point of reference.
  - `?=` (Conditional): Set default values that callers can override.
  - `!=` or `$(shell ...)`: Execute shell commands deterministically.
- **Automatic Variables:** Favour automatic variables to maintain DRY rules:
  - `$@`: The target filename.
  - `$<`: The first prerequisite.
  - `$^`: All prerequisites with duplicates removed.
  - `$*`: Stem of pattern rules (e.g. `%.o: %.c`).
- **Phony Targets:** Explicitly declare all non-file targets in `.PHONY` (e.g.
  `all`, `test`, `lint`, `clean`, `help`) to prevent collisions with matching
  filenames.
- **Self-Documenting Help:** Provide a `help` target parsing `##` target
  comments with `awk` or `grep` as the default or discoverable guide.

## Safety & Defensive Directives

- **Delete Incomplete Targets:** Always include `.DELETE_ON_ERROR:` to ensure
  Make automatically removes target files if recipe commands exit non-zero.
- **Defensive Shell Execution:** Set explicit shell parameters to prevent
  masked pipeline failures:

  ```make
  SHELL := bash
  .SHELLFLAGS := -euo pipefail -c
  ```

- **Strict Variable Scoping:** Enable undefined variable warnings:

  ```make
  MAKEFLAGS += --warn-undefined-variables
  ```

- **Compound Recipes:** Use `.ONESHELL:` when recipes require shared subshell
  state, inline scripts, or error-trapping blocks.

## Review & Output Contract

When reviewing or authoring Makefile code, organise output into:

1. **Summary:** Scope of Makefile modifications or target execution plan.
2. **Syntax & Directives:** Validation of tab indentation, `.PHONY` targets,
   and safety flags (`.DELETE_ON_ERROR:`, `.SHELLFLAGS`).
3. **Dependency Graph & Idempotency:** Prerequisite correctness, file targets
   versus phony targets, and clean caching behaviour.
4. **Recipe Safety & Portability:** Defensive command execution, shell flag
   hygiene, and elimination of silent failure suppression.
5. **Suggested Code / Diff:** Idiomatic, well-commented GNU Makefile code.

## Cross-Skill References

- **`shell-programmer`** — Validate recipe commands, shell quoting, and trap
  handlers.
- **`ansible-programmer`** — Coordinate Make targets with Ansible automation.
- **`python-programmer`** — Drive `uv`, `pytest`, and `ruff` via Make.
- **`markdown-editor`** — Format target documentation and user guides.

## Resources

- Manual: [GNU Make Manual](https://www.gnu.org/software/make/manual/)
- Standard: [POSIX Make Specification][posix-make]
- Linter: [checkmake](https://github.com/mrtazz/checkmake)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)

[posix-make]:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
