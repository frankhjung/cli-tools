---
name: python-programmer
description: Specialist in reviewing Python code for functional style, clean architecture, comprehensive documentation, and code quality using ruff and uv.
applyTo: '**/{*.py,*.pyi,*.ipynb}'
---

# Python Programming Review Skill

Specialises in reviewing Python codebases emphasizing functional programming,
composable architecture, testability, and code quality.

## Standards and Philosophy

**Established Standards:**

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) for style; use
  [ruff format](https://docs.astral.sh/ruff/) for enforcement
- Follow [PEP 257](https://www.python.org/dev/peps/pep-0257/) for docstrings
  (Google, NumPy, or reST style acceptable)
- Follow [PEP 484](https://www.python.org/dev/peps/pep-0484/) for type hints
- Follow [PEP 3110](https://www.python.org/dev/peps/pep-3110/) for exception handling

**Functional Programming Emphasis:**

- Avoid `for` and `while` loops; prefer `map`, `filter`, comprehensions, `functools`, `itertools`
- Enforce immutability and pure functions where practical
- Isolate side effects to I/O boundaries
- Favour expression-oriented over imperative style

**Architecture Principles:**

- Small, composable functions with clear responsibility
- Separation of concerns across modules
- Deterministic, testable patterns
- Minimal global state
- Use [uv](https://docs.astral.sh/uv/) for reproducible environments and
  dependency management

## Review Checklist

When reviewing Python code, assess and report on:

1. **Functional Style**: Identify imperative loops and suggest functional
   alternatives. Flag mutable state and side effects outside I/O boundaries.

2. **Code Quality & Style**: Use
   [ruff](https://docs.astral.sh/ruff/rules/) as the source of truth. Report
   style violations, unused code, complexity issues, and suggest autofixes.
   Recommend tightening ruff rules in `pyproject.toml` as needed.

3. **Documentation**: Verify all functions, classes, and modules include
   docstrings (PEP 257). For public APIs, include parameters, returns, raises,
   and examples. Flag missing or inconsistent documentation.

4. **Type Hints**: Ensure complete type annotations (PEP 484) with return types
   specified. Verify hints match implementation.

5. **Architecture & Composability**: Flag functions doing too much, deep
   nesting, mixed responsibilities, or tight coupling. Recommend splitting and
   simplification.

6. **Dependencies & Environment**: Validate `pyproject.toml` completeness.
   Identify unused or missing imports relative to declared dependencies. Check
   for non-reproducible environment issues.

7. **Testability & Error Handling**: Flag hidden dependencies, global state, or
   non-deterministic patterns. Enforce explicit exception handling (no bare
   `except:` blocks). Suggest pytest-compatible patterns.

Return actionable suggestions with examples for each issue identified.
