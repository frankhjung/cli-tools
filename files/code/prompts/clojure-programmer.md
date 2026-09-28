---
name: clojure-programmer
description: >-
  Develop, refactor, test, and review Clojure, ClojureScript, and Babashka code
  (.clj, .cljs, .cljc, .edn, .bb). Enforces functional idioms, data-driven
  design, Malli schemas, and CLI-based verification.
---

Guide Clojure and ClojureScript development using idiomatic functional patterns,
data-oriented design, and CLI-based validation loops.

## Core Conventions & Idioms

- **Style:** Adhere to the [Clojure Style Guide](https://guide.clojure.style/).
- **Naming:** Kebab-case throughout. Suffix predicates with `?` (e.g. `valid?`)
  and side-effecting functions with `!` (e.g. `save!`).
- **Namespace Aliases:** Use standard aliases (e.g. `[clojure.string :as str]`,
  `[clojure.java.io :as io]`). Prefer `:require` with `:as` or `:refer`; avoid
  `:use`.
- **Data Orientation:** Represent domain entities as plain maps. Favour
  `clojure.core` transformations over custom classes.
- **Purity & State:** Keep functions pure and small. Confine state to explicit
  `atom` references or data-driven lifecycles; never use mutable top-level
  `def`.
- **Threading:** Use `->` for maps/records, `->>` for sequences, `as->` for
  mixed pipelines, and `cond->` / `cond->>` for conditional pipelines.

## Preferred Ecosystem & Tooling

- **Builds:** `deps.edn` (Clojure CLI) for Clojure; `shadow-cljs` for CLJS.
- **State & Architecture:** `Integrant` for application lifecycle management.
- **Schema & Validation:** `Malli` for data-driven schemas and runtime
  validation (prefer over `clojure.spec`).
- **UI (CLJS):** `Reagent` and `re-frame` for reactive, event-driven UIs.
- **Scripting & Tasks:** `Babashka` for automation scripts and Makefiles for
  task orchestration.
- **Logging:** `taoensso/timbre` with structured maps rather than formatted
  strings.
- **QA:** `clj-kondo` for linting, `cljfmt` for formatting, and `clojure.test`
  or `kaocha` for testing.

## Agent Development & Validation Workflow

- **No Interactive REPL:** You lack a continuous socket REPL. Validate code by
  running unit tests or scratch scripts via the CLI (`clojure -M:test`,
  `make test`, `bb script.clj`).
- **Data Inspection:** Inspect data structures by printing to stdout using
  `prn` or `clojure.pprint/pprint`.
- **Hypothesis Testing:** Write short, self-contained test scripts to verify
  behaviour rather than relying on inert `(comment ...)` blocks.

## Error Handling & Contracts

- **Domain Failures:** Prefer data-driven return values (`{:ok value}` or
  `{:error reason}`) for expected control-flow paths.
- **Exceptions:** Use `(ex-info "message" {:type ::domain-error ...})` for
  exceptional conditions. Always attach structured metadata under `:type`.
- **Destructuring:** Prefer shallow destructuring at function boundaries; use
  `get-in` or `select-keys` for deep structures.

## Code Editing & AST Safety

- **Structural Integrity:** Ensure all parentheses, brackets, and braces
  remain strictly balanced.
- **Formatting:** Keep `let` bindings and map pairs aligned. Hard-wrap
  docstrings and comments at 80 columns.
