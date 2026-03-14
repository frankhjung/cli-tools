---
name: clojure-programmer
description: Review Clojure and ClojureScript codebases emphasising functional programming idioms.
---

Guide Clojure and ClojureScript development using an AI-friendly workflow,
idiomatic coding conventions, and functional best practices. Use when writing,
developing, or refactoring Clojure or ClojureScript code.

## Core Principles & Conventions

- **Style Guide:** Adhere strictly to the [Clojure Style
  Guide](https://guide.clojure.style/).
- **Namespace Aliases:** Use consistent, idiomatic aliases (e.g.,
  `[clojure.string :as str]`, `[clojure.java.io :as io]`). Never use `:use`;
  prefer `:require` with `:as` or `:refer`.
- **Threading Macros:** Use `->` (thread-first) when operating on maps/records
  and `->>` (thread-last) when operating on sequences. Use `as->` for irregular
  pipelines and `cond->` / `cond->>` for conditional threading.
- **Naming:** Enforce kebab-case. Use `?` for predicates (e.g., `valid?`) and
  `!` for side-effecting functions (e.g., `save!`).
- **Data-Oriented Programming:** Represent domain entities as plain maps.
  Leverage `clojure.core` functions for data manipulation instead of custom
  classes.
- **Immutability:** Default to immutable data structures. Only use `atom` or
  `ref` for explicitly managing shared, mutable state.
- **Purity:** Keep functions small, focused, and pure (side-effect free)
  whenever possible. Favour library composition over monolithic frameworks.

## Ecosystem & Tooling

- **Dependency & Build Management:** Default to `deps.edn` (Clojure CLI) for
  Clojure projects, and `shadow-cljs` for ClojureScript.
- **State Management:** Use data-driven lifecycle libraries like `Integrant`
  over global state management.
- **Validation:** Use Malli for data-driven schemas, runtime validation, and
  parsing over `clojure.spec`.
- **QA:** Use `clj-kondo` for static analysis and linting, `cljfmt` for code
  formatting, and `clojure.test` for unit testing. Use `kaocha` as an
  alternative test runner for richer output and configuration.
- **Scripting:** Use `babashka` for shell-script replacement and task automation
  within the Clojure ecosystem.
- **Logging:** Use `taoensso/timbre` for structured, data-driven logging. Prefer
  structured log maps over format strings.
- **Task Runner:** Use a Makefile to automate common tasks like running tests,
  linting, and formatting.

## Development Workflow

- **Validation Loop:** You do not have access to an interactive editor REPL.
  Validate code by writing comprehensive unit tests and executing them via the
  CLI (e.g., `clojure -M:test`, `make test`, or executing a `babashka` script).
- **Data Inspection:** Do not use GUI-based REPL tools like `portal` or
  `reveal`. Instead, print data structures to standard output using `prn` or
  `clojure.pprint/pprint` so you can read and analyse the terminal output.
- **Experimentation:** When you need to test assumptions, write short executable
  scripts or temporary test files and run them using shell commands, rather than
  writing inert code inside `(comment ...)` blocks that you cannot directly
  evaluate interactively.
- **Incremental Steps:** Build programs by composing small, independent,
  thoroughly tested functions.

## Project Structure

- **Source Layout:** Follow the standard `src/` and `test/` directory split.
  Mirror the namespace hierarchy in the directory structure (e.g.,
  `my.app.core` → `src/my/app/core.clj`).
- **Namespace Organisation:** One namespace per file. Keep namespaces focused;
  split large namespaces by concern (e.g., `db`, `api`, `domain`).
- **Documentation:** Add docstrings to all public vars (`defn`, `def`,
  `defmulti`). Generate API docs with Codox. Keep private helpers (`defn-`)
  undocumented or with brief inline comments.

## Destructuring

- **Sequential:** Destructure vectors and lists positionally:
  `(let [[a b & rest] coll] ...)`.
- **Associative:** Destructure maps by key: `(let [{:keys [name age]} person]
  ...)`. Use `:strs` and `:syms` for string/symbol keys.
- **Nested:** Compose sequential and associative destructuring freely, but
  prefer shallow destructuring for readability. Extract deeply nested values
  with `get-in` or `select-keys` rather than deep destructuring.
- **Function Arguments:** Apply destructuring directly in `defn` argument lists
  to clarify intent at the call boundary.

## Error Handling

- **`ex-info`:** Throw structured errors using `(ex-info "message" {:type
  ::domain-error :context ...})`. Always include a `:type` key for programmatic
  handling.
- **`ex-data`:** Extract error context with `(ex-data e)` in catch clauses.
  Pattern-match on `:type` to handle domain vs. infrastructure errors
  differently.
- **Data-Driven Returns:** For expected failure paths, prefer returning tagged
  values (e.g., `{:ok result}` / `{:error reason}`) over throwing exceptions.
  Reserve exceptions for truly unexpected conditions.
- **Avoid Swallowing Exceptions:** Never catch `Throwable` or bare `Exception`
  without logging and re-throwing or returning a structured error.

## Testing

- **Structure:** Mirror the source namespace in test namespaces (e.g.,
  `my.app.core` → `my.app.core-test`). One test namespace per source namespace.
- **`deftest` / `is`:** Use `clojure.test/deftest` and `is` for assertions.
  Group related assertions under a single `deftest`; use nested `testing` blocks
  to label sub-cases.
- **Fixtures:** Use `use-fixtures` with `:each` or `:once` to set up and tear
  down state (e.g., database connections, temp files).
- **Mocking:** Prefer passing dependencies as arguments (dependency injection)
  over global state. Use `with-redefs` sparingly for third-party side effects.
- **Property Testing:** Consider `test.check` for generative tests on pure
  functions with well-defined invariants.

## Concurrency

- **Atoms:** Use `atom` with `swap!` / `reset!` for uncoordinated, synchronous,
  independent state changes.
- **Refs & STM:** Use `ref` with `dosync` / `alter` / `commute` when multiple
  pieces of state must change atomically.
- **Agents:** Use `agent` for asynchronous, uncoordinated state changes where
  ordering within a single agent is required.
- **Futures & Promises:** Use `future` for fire-and-forget background work; use
  `promise` / `deliver` for one-shot async handoffs.
- **`core.async`:** Use channels and `go` blocks for complex async pipelines
  and producer/consumer patterns. Prefer `pipeline` and `pipeline-async` over
  manual channel wiring for parallelism.

## Java Interop

- **Prefer Clojure Wrappers:** Always check for an idiomatic Clojure library
  before reaching for Java interop directly.
- **Method Calls:** Use `.method` syntax for instance methods and
  `ClassName/method` for statics.
- **Type Hints:** Add type hints (e.g., `^String`, `^long`) on interop-heavy
  hotpaths to avoid reflection and improve performance.
- **Resource Management:** Use `with-open` for any `java.io.Closeable` to
  ensure deterministic cleanup.

## ClojureScript

- **Build Tool:** Use `shadow-cljs` for all ClojureScript compilation and REPL
  connections.
- **UI Frameworks:** Use `reagent` (React wrapper) for component-based UIs, and
  `re-frame` for structured, event-driven state management.
- **JS Interop:** Access JS globals via `js/` (e.g., `js/console.log`). Use
  `clj->js` / `js->clj` for data conversion at the boundary. Prefer `:require`
  with `:as` over `goog.module` imports.
- **Build Targets:** Separate `:dev`, `:test`, and `:release` build targets in
  `shadow-cljs.edn`. Always verify advanced compilation output for externs and
  dead-code elimination.

## Critical Rules for Code Editing

- **AST Integrity:** Treat the code as a tree. Ensure absolute precision with
  parentheses, brackets, and brace balancing when modifying code.
- **Formatting:** Keep tabular code vertically aligned (e.g., `let` bindings,
  map keys) for readability.
- **Cleanups:** Remove trailing spaces on empty lines. Ensure files end with a
  single newline.
- **No Mutable Globals:** Never use bare `def` to hold mutable state at the top
  level. Use `defonce` only when a singleton is genuinely required, and manage
  it via `atom` with explicit reset semantics.
