---
name: review-skills
description: >-
  Review, refine, and audit Antigravity rule files (global ~/.gemini/GEMINI.md
  and workspace GEMINI.md) and skills (SKILL.md) for optimal performance with
  latest Gemini models. Use this skill when auditing skills, tuning prompt
  directives, optimising context budgets, or resolving instruction drift.
---

# Review Skills

Review and audit Antigravity workspace rules (`GEMINI.md`) and skill definitions
(`SKILL.md`) to maximise instruction fidelity, routing accuracy, and context
efficiency when running with Google Gemini models.

## Core Audit Dimensions

Evaluate rule and skill files across six architectural dimensions:

### 1. Frontmatter Quality & Routing Accuracy

- **Unique Identifier (`name`):** Must be lowercase, hyphenated, and match the
  parent directory name (e.g. `skills/<name>/SKILL.md`).
- **Trigger Description (`description`):**
  - Written in third person ("Use this skill when...").
  - Must state both **what** the skill provides and **when** the model should
    activate it.
  - Include relevant file extensions (e.g. `.elm`, `.hs`), tooling keywords,
    and workflow triggers.
  - Avoid overly generic phrasing that causes false-positive skill activations.

### 2. Context Budget & Progressive Disclosure

- **Concise Core Instructions:** Keep `SKILL.md` under 200 lines where
  practical. Avoid injecting encyclopaedic reference manuals into the primary
  context.
- **Reference Offloading:** Move extensive code examples, large sample modules,
  and long configuration templates into `examples/` or `references/` subfolders,
  linking to them via relative markdown links.
- **No Redundant Teaching:** Avoid explaining foundational programming concepts
  that Gemini already knows natively. Focus strictly on project conventions,
  invariants, architectural patterns, and validation loops.

### 3. Antigravity Tool Alignment & Sandbox Ergonomics

- **Accurate Tool Names:** Reference actual Antigravity tools:
  - `read_file`, `write_file`, `edit_file` (avoid legacy `view_file` or
    `list_dir`).
  - `run_command` (with `git grep` or `rg` for searching).
  - Subagents (`research`, `browser`, `image-generator`, `self`).
  - Interactive tools (`ask_question` for multi-choice user input).
- **Prefix-Matchable CLI Execution:** Avoid shell constructs in recommended
  commands that break Antigravity's prefix-based auto-approval (e.g. `$(...)`
  subshells, `env` wrappers, or `&&` chains). Recommend direct binary
  invocations with literal arguments.
- **Non-Interactive Validation:** Models lack persistent interactive REPL or
  IDE sockets. Ensure skills provide CLI batch commands, syntax dry-runs, or
  scratch-script workflows (`python -c`, `Rscript -e`, `bb -e`, `ghc -e`).

### 4. Instruction Clarity & Output Gating for Gemini

- **Single H1 Title:** Every `SKILL.md` must start with a single top-level `#`
  heading following the YAML frontmatter.
- **Output Contract Gating:** Explicitly gate heavy review reporting sections
  with: *"Apply this output structure only when the user asks for a review or
  audit. For implementation or bug-fix tasks, apply edits directly, run
  verification, and report concisely."* This prevents Gemini from emitting
  verbose multi-section audit templates during simple code edits.
- **Positive Replacement Framing:** Pair negative constraints ("Never use X"
  or "Avoid Y") with an explicit positive alternative ("Use Y instead" or
  "Prefer Z"). Gemini models follow paired directives with significantly
  higher compliance than open-ended negative prohibitions.
- **Unambiguous Directives:** Use clear imperative verbs rather than passive
  suggestions. Highlight strict invariants as bullet points.

### 5. Project Mandates & Style Adherence

- **80-Column Limit:** Hard-wrap all prose, documentation, and markdown at 80
  columns. Keep code examples within language limits (e.g. 88 characters for
  Python Ruff). Exempt long URLs, tables, and Mermaid diagrams where wrapping
  breaks syntax.
- **Language Standards:**
  - Australian English for documentation, prose, and comments (`optimise`,
    `prioritise`, `standardise`, `colour`, `artefacts`, `behaviour`).
  - US English for code tokens, keywords, and diffusion prompts.
- **Link Formatting:** Use reference-style links or short descriptive links to
  prevent URL line overflows.

### 6. Workspace & Project Rule Consistency (`GEMINI.md`)

- **Routing Parity:** Ensure every skill in `skills/` is represented in the
  `## Expert Routing` table in `~/.gemini/GEMINI.md`.
- **Deduplication:** Avoid repeating large instruction blocks across both
  `GEMINI.md` and individual skills. `GEMINI.md` sets global or workspace
  guardrails; skills supply specialised workflows on demand.
- **Ground-Truth Verification:** Ensure all tools, scripts, file paths, and
  Makefile targets referenced in workspace `GEMINI.md` rules exist in the
  codebase (e.g. `make resume-task` rather than stale targets).
- **Sandbox-Safe Validation:** Clearly distinguish commands safe for standard
  sandbox execution (`make lint`, `make test`) from those requiring live host
  or root execution (`make`, `sudo`).

## Audit Workflow

1. **Inventory & Discovery:** Inspect `GEMINI.md` and all `skills/*/SKILL.md`
   files using `read_file` or `run_command`.
2. **Dimension Audit:** Systematically evaluate each file against the six core
   audit dimensions above.
3. **Line Length Check:** Verify 80-column compliance across all documentation
   files using a script or terminal check.
4. **Draft Refinements:** Formulate concrete, minimal line edits preserving
   existing functionality while optimising model steering.
5. **Lint & Verify:** Run `make lint` to confirm playbook syntax and role
   integrity.

## Review & Output Contract

Apply this output structure **only** when the user asks for a review or audit of
rules and skills. For direct editing or skill creation tasks, apply edits
directly, run verification, and report concisely:

1. **Executive Summary:** Overview of rule/skill health and key findings.
2. **Routing & Frontmatter:** Description clarity, keyword triggers, and
   `GEMINI.md` routing table alignment.
3. **Context & Progressive Disclosure:** Token efficiency, modularity, and
   offloaded reference opportunities.
4. **Tooling & Ergonomics:** Antigravity tool naming, prefix-matchable commands,
   and CLI verification loops.
5. **Language & Formatting:** 80-column wrapping, Australian English spelling,
   and heading hierarchy.
6. **Suggested Code / Diff:** Concrete, idiomatic file modifications.

## Cross-Skill References

- **`markdown-editor`** — Validate Markdown syntax, headings, and 80-column
  wrapping.
- **`architecture-review`** — FP architectural patterns and modularity.
- **`shell-programmer`** — Validate CLI command patterns and scripting hygiene.
- **`agy-customizations`** — Reference for Antigravity rules, skills, plugins,
  and loading priorities.

## Resources

- Antigravity Customisations: [Antigravity Customisations Guide][agy-custom]
- Style: [The Guardian Style Guide][guardian-style]
- Dictionary: [Macquarie Dictionary][macquarie] (Australian English)

[agy-custom]:
https://github.com/google-deepmind
[guardian-style]:
https://www.theguardian.com/guardian-observer-style-guide-a
[macquarie]:
https://www.macquariedictionary.com.au/
