# Project Mandates

## 80-Column Limit

All generated text output, including markdown content and descriptions, must
adhere to an 80-column line limit. This applies to all content, not just code.

## Spelling

- Use Australian English for all documentation text.
- Use US English for code.

## Expert Routing

Automatically prioritise the use of specialised skills based on task context:

- **Code:**
  - `clojure-programmer`: Clojure, ClojureScript, Babashka (`.clj`, `.cljs`,
    `.bb`, `deps.edn`).
  - `gnur-programmer`: GNU R scripts and packages (`.R`, `.Rmd`, `testthat`).
  - `haskell-programmer`: Haskell codebases (`.hs`, `.lhs`, `.cabal`).
  - `lean-programmer`: Lean 4 code and proofs (`.lean`, `lakefile.lean`).
  - `python-programmer`: Modern Python 3.14+ (`.py`, `pyproject.toml`).
  - `shell-programmer`: Bash and POSIX shell scripts (`.sh`, `.bash`).
- **Documentation:**
  - `blog-editor`: Technical blog post reviews and metadata validation.
  - `dokuwiki-editor`: DokuWiki pages and wiki documents (`.txt`).
  - `markdown-editor`: Markdown formatting, linting, and structure (`.md`).
- **Planning & Architecture:**
  - `architecture-review`: Codebase architecture and FP refactoring.
  - `requirements-review`: Interactive requirements grilling and glossary
    reconciliation.

## Resources

- Style:
  [The Guardian style guide](https://www.theguardian.com/guardian-observer-style-guide-a)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
  (Australian English)
- Rhetoric:
  [Aristotle's Rhetoric](https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work))
  — logical fallacies and argument structure
