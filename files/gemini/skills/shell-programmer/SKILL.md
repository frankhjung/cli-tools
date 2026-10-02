---
name: shell-programmer
description: >-
  Develop, refactor, lint, and review Bash and POSIX shell scripts
  (.sh, .bash). Use this skill when developing, refactoring, linting,
  testing, or reviewing shell scripts. Enforces defensive scripting
  (set -euo pipefail), ShellCheck compliance, functional pipelines, and
  portability standards.
---

# Shell Programmer

Guide shell script development and review, emphasising defensive execution,
functional composition, ShellCheck compliance, and POSIX portability.

## Safety & Defensive Scripting

- **Strict Modes:**
  - Bash: `set -Eeuo pipefail`, `shopt -s inherit_errexit` (Bash 4.4+), and
    `IFS=$'\n\t'` at script entry.
  - POSIX `sh`: `set -eu`.
- **Variable Expansions:** Strictly double-quote all parameter expansions
  (`"${var}"`, `"$@"`) to prevent word splitting and globbing.
- **Conditionals:** Use `[[ ... ]]` for Bash scripts; use `[ ... ]` (with `=`
  not `==`) for POSIX `sh`.
- **Resource Cleanup:** Use `trap` handlers for deterministic temporary file
  and process cleanup: `trap 'cleanup' EXIT INT TERM`.
- **Dependency Checks:** Verify required external tools early with
  `command -v tool >/dev/null 2>&1 || exit 1`.
- **Script Locality:** Determine script directory safely:
  `readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"`.
- **Error Handling:** Check return statuses of external commands; provide
  informative error messages to stderr before exiting non-zero.

## Functional Style & Modularity

- **Scope & Immutability:** Declare all function variables with `local` (or
  `local -r` for constants in Bash). Avoid global state mutation.
- **Pure Pipelines:** Favour stream composition via pipes (`|`), `jq`, `awk`,
  and `xargs` over mutable iterative loops.
- **Entrypoint Structure:** Encapsulate script logic in small, single-task
  functions orchestrated by a `main "$@"` entrypoint.

## Portability & Formatting

- **Portability:** If using `#!/bin/sh`, strictly reject Bashisms (e.g. arrays,
  `[[ ... ]]`, `source`, `function` keyword, `${var/search/replace}`).
- **Formatting & Style:** 2-space indentation; hard-wrap comments and prose
  at 80 columns. Use `snake_case` for functions/variables and `UPPER_CASE`
  for environment variables.
- **Long-Form Options:** Prefer readable long-form flags (e.g. `--directory`
  over `-d`) in scripts.
- **Tooling & Tests:** Clean passes with `shellcheck`, formatting via `shfmt`,
  and automated testing using `bats-core` under `test/`.
- **Task Runner:** Use `Makefile` targets (`make check`, `make format`,
  `make test`).

## Review & Output Contract

When reviewing or refactoring shell code, organise output into:

1. **Summary:** Architectural overview and safety assessment.
2. **Safety & Error Handling:** Missing quotes, unprotected expansions, traps,
   or unchecked command exits.
3. **Functional Style & Modularity:** Scoping (`local`), decomposition, and
   pipeline composition.
4. **ShellCheck & Portability:** ShellCheck warnings and POSIX compliance.
5. **Suggested Code / Diff:** Idiomatic, safe shell implementation.

## Cross-Skill References

- **`makefile-programmer`** — Coordinate `Makefile` targets for script checks.
- **`ansible-programmer`** — Manage shell scripts and commands in Ansible.
- **`markdown-editor`** — Format script documentation and markdown comments.

## Resources

- Linter: [ShellCheck](https://github.com/koalaman/shellcheck)
- Formatter: [shfmt](https://github.com/mvdan/sh)
- Testing: [bats-core](https://github.com/bats-core/bats-core)
- Style Guide:
  [Google Shell Guide](https://google.github.io/styleguide/shellguide.html)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
