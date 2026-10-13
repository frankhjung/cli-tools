---
name: python-programmer
description: >-
  Develop, refactor, test, and review modern Python 3.14+ codebases (.py,
  pyproject.toml). Enforces functional programming idioms, PEP 695 type
  parameters, frozen dataclasses, ruff/uv tooling, and property testing.
---

Guide Python development using modern functional idioms, strict Python 3.14+
type annotations, pure domain modelling, and fast `uv`/`ruff` tooling.

## Coding Style & Formatting

- **Indentation & Line Length:** 4 spaces indentation per PEP 8. Hard-wrap
  docstrings, markdown, and comments at 80 columns. Keep code within 88
  characters (Ruff default).
- **Naming:** `snake_case` for variables, functions, and modules; `PascalCase`
  for classes, type aliases, and Protocols; `UPPER_CASE` for constants.
- **Linters & Formatters:** Enforce code quality via `ruff` (`ruff check`,
  `ruff format`).

## Functional Programming Foundations

- **Pure Core, Effectful Shell:** Keep core business logic pure and
  deterministic. Push I/O and side effects to application edges (`__main__`
  or CLI handlers).
- **Functional Constructs:** Avoid imperative loops where comprehensions,
  `map`, `filter`, `functools`, or `itertools` are cleaner.
- **Immutability:** Favour immutable data structures (`tuple`, `frozenset`,
  `types.MappingProxyType`, and `@dataclass(frozen=True, slots=True)`).

## Python 3.14+ Type System & Domain Modelling

- **PEP 695 Type Syntax:** Use native type aliases and type parameters:
  - `type Result[T] = Success[T] | Failure`
  - `def execute[T](action: Action[T]) -> T:`
- **Union & Generics:** Use `X | Y` (never `Union`/`Optional`) and built-in
  generics (`list[T]`, `dict[K, V]`).
- **Protocols & ADTs:**
  - Define interfaces with `typing.Protocol` (structural subtyping).
  - Model domain variants using frozen dataclass sum types with
    `match ... case` pattern matching.
- **Exception Safety:** Use specific exception types; support `ExceptionGroup`
  and `except*` where appropriate. Never use bare `except:`.

## Testing, Tooling & Workflow

- **Environment & Build (`uv`):** Use `uv run` for execution and `uv add` for
  dependencies managed in `pyproject.toml`.
- **Testing:** Use `pytest` for unit testing and `Hypothesis` for generative
  property-based testing on pure functions under `tests/`.
- **Documentation:** PEP 257 docstrings (`"""..."""`) on all public functions,
  classes, and modules.
- **Task Runner:** Use `Makefile` targets (`make format`, `make check`,
  `make test`, `make build`, `make clean`).

## Review & Output Contract

When reviewing or refactoring Python code, organise output into:

1. **Summary:** Architectural overview and design quality.
2. **Type System & PEP 695:** Type coverage, protocol usage, and modern syntax.
3. **Functional Architecture & Immutability:** Pure function opportunities,
   side-effect containment, and data modelling.
4. **Tooling & Quality:** Ruff diagnostics, docstrings, and test coverage.
5. **Suggested Code / Diff:** Idiomatic, tested Python 3.14 implementation.

## Resources

- Package Manager: [uv Documentation](https://docs.astral.sh/uv/)
- Linter & Formatter: [Ruff Documentation](https://docs.astral.sh/ruff/)
- Test Framework: [pytest](https://docs.pytest.org/),
  [Hypothesis](https://hypothesis.readthedocs.io/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
