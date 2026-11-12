# Project Mandates

## 80-Column Limit

All generated prose, comments, docstrings, and markdown descriptions must
adhere to an 80-column hard line limit. Long URLs, wide markdown tables,
Mermaid diagrams, and language-specific code formatter limits (such as Ruff's
88-character default) are exempt where wrapping would break syntax or tooling.

## Spelling

- Use Australian English for all documentation text.
- Use US English for code.

## Expert Routing

Automatically activate and read the matching specialised skill from `<skills>`
before developing, refactoring, testing, or reviewing files:

- **Code & Infrastructure:**
  - `ansible-programmer`: Ansible roles, playbooks, and inventories (`.yaml`).
  - `clojure-programmer`: Clojure, ClojureScript, Babashka (`.clj`, `.cljs`,
    `.bb`, `deps.edn`).
  - `elm-programmer`: Elm applications and packages (`.elm`, `elm.json`).
  - `gnur-programmer`: GNU R scripts and packages (`.R`, `.Rmd`, `testthat`).
  - `haskell-programmer`: Haskell codebases (`.hs`, `.lhs`, `.cabal`).
  - `lean-programmer`: Lean 4 code and proofs (`.lean`, `lakefile.lean`).
  - `makefile-programmer`: Makefile editing and target execution (`Makefile`,
    `*.mk`).
  - `python-programmer`: Modern Python 3.14+ (`.py`, `pyproject.toml`).
  - `shell-programmer`: Bash and POSIX shell scripts (`.sh`, `.bash`).
  - `typescript-programmer`: TypeScript, Node.js, and web codebases (`.ts`,
    `.tsx`, `package.json`, `tsconfig.json`).
- **Documentation & Media:**
  - `blog-banner-creator`: 16:9 coloured pencil blog banner illustrations.
  - `blog-editor`: Technical blog post reviews and metadata validation.
  - `dokuwiki-editor`: DokuWiki pages and wiki documents (`.txt`).
  - `markdown-editor`: Markdown formatting, linting, and structure (`.md`).
- **Planning & Architecture:**
  - `architecture-review`: Codebase architecture and FP refactoring.
  - `requirements-review`: Interactive requirements grilling and glossary
    reconciliation.
  - `review-skills`: Review Antigravity rules and skills for optimal Gemini
    performance and context efficiency.

## Resources

- Style: [The Guardian Style Guide][guardian-style]
- Dictionary: [Macquarie Dictionary][macquarie] (Australian English)
- Rhetoric: [Aristotle's Rhetoric][rhetoric] — logical fallacies and argument
  structure

[guardian-style]:
https://www.theguardian.com/guardian-observer-style-guide-a
[macquarie]:
https://www.macquariedictionary.com.au/
[rhetoric]:
https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work)
