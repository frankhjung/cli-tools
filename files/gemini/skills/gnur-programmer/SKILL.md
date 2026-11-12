---
name: gnur-programmer
description: >-
  Develop, refactor, test, and review GNU R code (.R, .Rmd). Enforces
  functional programming idioms, vectorisation, tidyverse/base R style,
  Roxygen2 documentation, and testthat unit testing.
---

# GNU R Programmer

Guide GNU R development with a focus on functional programming principles,
vectorisation, clean code structure, and comprehensive documentation.

## Core Standards & Functional Idioms

- **Language & Style:** Adhere to the Tidyverse Style Guide. Use `snake_case`
  for functions and variables.
- **Line Length & Indentation:** 2-space indentation; hard-wrap prose and
  comments at 80 columns.
- **Functional Programming:**
  - Avoid explicit loops (`for`, `while`). Use vectorised functions or mapping
    helpers (`purrr::map_*`, `vapply`, `lapply`).
  - Keep functions pure, small, and deterministic without hidden mutations of
    the global environment.
  - Favour function composition using the native pipe `|>` (or `%>%`).
- **Data & Performance:**
  - Leverage native vectorisation over iterative element/row processing.
  - Avoid growing objects in loops; pre-allocate vectors or use list
    accumulators.
  - Prefer `data.table` or `dplyr`/`tibble` for tabular data pipelines.
- **Error Handling:** Use informative, explicit signals (`cli::cli_abort`,
  `rlang::abort`, or `stop()`). Avoid silent failures.

## Documentation & Testing Standards

- **Roxygen2:** Document all exported functions with `@title`, `@description`,
  `@param`, `@return`, and runnable `@examples`.
- **Testing:** Structure tests using `testthat` in `tests/testthat/`. Ensure
  pure functions have isolated unit tests.
- **Linting & Formatting:** Validate styling using `styler` and `lintr`.

## Agent Development & Validation Workflow

- **No Interactive R Session:** Validate code via non-interactive CLI commands
  (`make test`, `make check`, or `Rscript -e "testthat::test_local()"`).
- **Static Check Pre-Flight:** Run `Rscript -e "lintr::lint('<file>')"` to
  verify style compliance and catch syntax issues rapidly.
- **Fast Hypothesis Testing:** Use `Rscript -e "..."` or short scripts in the
  session scratch directory to verify vectorised expressions and edge cases.

## Review & Output Contract

Apply this output structure **only** when the user asks for a code review or
audit. For implementation or bug-fix tasks, apply edits directly, run
verification, and report concisely:

1. **Summary:** High-level assessment of code quality and functional design.
2. **Functional & Vectorisation:** Identified loops, side effects, or
   unvectorised bottlenecks with suggested replacements.
3. **Documentation & Roxygen2:** Missing tags, unexported helpers, or unclear
   parameter contracts.
4. **Code Quality & Modularity:** Long functions, naming improvements, and
   test recommendations.
5. **Suggested Code / Diff:** Concrete, idiomatic R implementation.

## Cross-Skill References

- **`architecture-review`** — Pure core / effectful shell and FP refactoring.
- **`blog-editor`** — Validate R Markdown (`.Rmd`) articles and code chunks.
- **`makefile-programmer`** — Coordinate `Makefile` targets for builds and
  tests.
- **`markdown-editor`** — Format documentation and vignettes.

## Resources

- Style: [Tidyverse Style Guide](https://style.tidyverse.org/)
- Documentation: [Roxygen2 Reference](https://roxygen2.r-lib.org/)
- Testing: [testthat Reference](https://testthat.r-lib.org/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
