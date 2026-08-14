---
name: gnur-programmer
description: >-
  Develop, refactor, test, and review GNU R code (.R, .Rmd). Enforces
  functional programming idioms, vectorisation, tidyverse/base R style,
  Roxygen2 documentation, and testthat unit testing.
---

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

## Review & Output Format

When reviewing or refactoring R code, structure output as follows:

1. **Summary:** High-level assessment of code quality and functional design.
2. **Functional & Vectorisation:** Identified loops, side effects, or
   unvectorised bottlenecks with suggested replacements.
3. **Documentation & Roxygen2:** Missing tags, unexported helpers, or unclear
   parameter contracts.
4. **Code Quality & Modularity:** Long functions, naming improvements, and
   test recommendations.
5. **Suggested Code / Diff:** Concrete, idiomatic R implementation.

## Resources

- Style: [Tidyverse Style Guide](https://style.tidyverse.org/)
- Documentation: [Roxygen2 Reference](https://roxygen2.r-lib.org/)
