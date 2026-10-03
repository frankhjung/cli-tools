---
name: clojure-programmer
description: >-
  Develop, refactor, test, and review Clojure, ClojureScript, and Babashka code
  (.clj, .cljs, .cljc, .edn, .bb). Use this skill when developing, refactoring,
  testing, linting, or reviewing Clojure codebases. Enforces functional
  idioms, data-driven design, Malli schemas, and CLI-based verification.
---

# Clojure Programmer

Guide Clojure and ClojureScript development using idiomatic functional patterns,
data-oriented design, Malli schemas, and CLI-based validation loops.

## Core Conventions & Idioms

- **Style:** Adhere to the [Clojure Style Guide](https://guide.clojure.style/).
  2-space indentation; hard-wrap docstrings and comments at 80 columns.
- **Naming:** Kebab-case throughout. Suffix predicates with `?` (e.g. `valid?`)
  and side-effecting functions with `!` (e.g. `save!`).
- **Namespace Aliases:** Use standard aliases (e.g. `[clojure.string :as str]`,
  `[clojure.java.io :as io]`). Prefer `:require` with `:as` or `:refer`; avoid
  `:use`.
- **Data Orientation:** Represent domain entities as plain maps with qualified
  keywords (e.g. `:user/id`, `::status`). Favour `clojure.core` transformations
  over custom classes or records.
- **Purity & State:** Keep functions pure and deterministic. Push side effects
  to application boundaries. Confine state to explicit `atom` references or
  lifecycle systems; never use mutable top-level `def`.
- **Threading & Transducers:** Use `->` for maps/records, `->>` for sequences,
  `as->` for mixed pipelines, and `cond->` / `cond->>` for conditional
  transformations. Favour transducers (`into [] (comp ...)`) for high-volume
  sequence processing.
- **Lazy Sequence Hygiene:** Ensure lazy sequences (`map`, `filter`) are
  explicitly realised with `doall`, `dorun`, or `into` when side effects or
  resource boundaries (`with-open`) are involved.

## Preferred Ecosystem & Architecture

- **Builds:** `deps.edn` (Clojure CLI) for Clojure; `shadow-cljs` for CLJS.
- **Lifecycle Management:** `Integrant` for application state and components.
- **Schema & Contracts:** `Malli` for data-driven schemas and runtime
  validation (prefer over `clojure.spec`). Use `malli.instrument/instrument!`
  during test suites.
- **UI (CLJS):** `Reagent` and `re-frame` for reactive, event-driven UIs.
- **Scripting & Tasks:** `Babashka` for automation scripts and Makefiles for
  task orchestration.
- **Logging:** `taoensso/timbre` with structured maps rather than string
  interpolation.
- **Linting & Formatting:** `clj-kondo` for static analysis and `cljfmt` for
  formatting.

## Agent Development & Validation Workflow

- **No Interactive REPL:** You lack a continuous socket REPL. Validate code by
  running unit tests or scratch scripts via the CLI (`clojure -M:test`,
  `make test`, `bb script.clj`).
- **Static Check Pre-Flight:** Run `clj-kondo --lint <file>` before executing
  tests to catch syntax errors and unresolved symbols without JVM startup lag.
- **Fast Hypothesis Testing:** Use `bb -e "(...)"` or short Babashka scripts in
  the session scratch directory for rapid verification of pure functions.
- **Data Inspection:** Inspect data structures by printing to stdout using
  `prn` or `clojure.pprint/pprint`. Avoid inert `(comment ...)` blocks in code
  intended for automated testing.

## Error Handling & Contracts

- **Domain Failures:** Prefer data-driven return values (`{:ok value}` or
  `{:error reason}`) for expected control-flow paths.
- **Exceptions:** Use `(ex-info "message" {:type ::domain-error ...})` for
  exceptional conditions. Always attach structured metadata under `:type`.
- **Destructuring:** Prefer shallow destructuring at function boundaries; use
  `get-in` or `select-keys` for deep structures.

## Code Editing & AST Safety

- **Structural Integrity:** Ensure all parentheses, brackets, and braces
  remain strictly balanced when applying edits.
- **Formatting:** Keep `let` bindings and map key-value pairs vertically
  aligned. Hard-wrap docstrings and comments at 80 columns.

## Review & Output Contract

When reviewing or refactoring Clojure code, organise findings into:

1. **Summary:** Architectural overview and design quality.
2. **Data-Oriented Design & Schemas:** Use of plain maps, namespaced keywords,
   and Malli contracts.
3. **Purity & State Isolation:** Pure core vs effectful shell, lazy sequence
   safety, and atom usage.
4. **Tooling & Verification:** Diagnostics from `clj-kondo`, tests, and
   formatting.
5. **Suggested Code / Diff:** Idiomatic, tested Clojure implementation.

## Cross-Skill References

- **`architecture-review`** — Pure core / effectful shell, polymorphic
  boundaries, and FP refactoring.
- **`requirements-review`** — Stress-test domain invariants and data models.
- **`makefile-programmer`** — Coordinate `Makefile` targets for builds and
  tests.
- **`markdown-editor`** — Format docstrings and markdown documentation.
- **`shell-programmer`** — Automate deployment and Babashka tasks.

## Resources

- Language: [Clojure Documentation](https://clojure.org/reference/documentation)
- Style Guide: [Clojure Style Guide](https://guide.clojure.style/)
- Schemas: [Malli Documentation](https://github.com/metosin/malli)
- Linter: [clj-kondo](https://github.com/clj-kondo/clj-kondo)
- Scripting: [Babashka Book](https://book.babashka.org/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
