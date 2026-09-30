# Gemini

This document contains Gemini CLI specific information and instructions.

## Extensions

There is not a specific command to list installed Gemini extensions. You can see
your installed extensions by listing the contents of the `~/.gemini/commands/`
directory. Each `.toml` file in that directory represents an extension.

Example extensions:

- dokuwiki: An expert to prepare and review Dokuwiki pages.
- plan: Investigates and creates a strategic plan to accomplish a task.

### Conductor

[Conductor](https://github.com/gemini-cli-extensions/conductor)

Conductor is a Gemini CLI extension that enables Context-Driven Development. It
turns the Gemini CLI into a proactive project manager that follows a strict
protocol to specify, plan, and implement software features and bug fixes.

To install the Conductor extension, run:

```bash
gemini extensions install https://github.com/gemini-cli-extensions/conductor --auto-update
```

## Quick Start: Gemini Rules and Skills in Antigravity

In Antigravity IDE, agent customisation is divided into **Rules** (persistent
behaviours, constraints, and process invariants) and **Skills** (modular,
task-oriented capabilities and tool bundles).

### 1. Rules vs. Skills

- **Rules:** Invariants and standard workflows applied automatically across
  sessions (e.g. following `developer-workflow.md`, coding standards, or test
  gates).

- **Skills:** Action-oriented, multi-step procedures and toolkits loaded on
  demand (e.g. running Lean 4 proof diagnostics, Clojure REPL interactions, or
  Python package builds).

### 2. Directory Layout

Place rules and skills either locally within your project workspace or globally
across all workspaces:

```text
my-project/
├── .agents/
│   ├── rules/
│   │   └── developer-workflow.md   # Project-specific rule
│   └── skills/
│       ├── lean4-proofs/
│       │   └── SKILL.md            # Modular skill instructions
│       └── clojure-repl/
│           ├── SKILL.md
│           └── scripts/            # Helper scripts executed as black boxes

```

**Global Locations:**

- Rules: `~/.gemini/config/rules/*.md` or `~/.gemini/AGENTS.md`
- Skills: `~/.gemini/config/skills/<skill-name>/SKILL.md`

### 3. Configuring Rules

Rules inside `.agents/rules/*.md` control the development loop:

```markdown
---
trigger: always_on
description: Standard development lifecycle
---
# Developer Workflow
Anchor every task to: Understand -> Plan -> Modify -> Make -> Test -> Review.
Always run `make test` before declaring code tasks complete.

```

- Rules are cumulative: project rules override or specialise global rules.
- Standalone `AGENTS.md` or `GEMINI.md` files at repository roots are treated as
  plain Markdown and remain permanently active (`always_on`).

### 4. Packaging Skills

Each skill resides in its own folder and requires a `SKILL.md` with YAML
frontmatter:

```markdown
---
name: lean4-proofs
description: Verify Lean 4 theorems and run proof diagnostics. Use when working with .lean files.
---
# Lean 4 Diagnostics
1. Inspect the theorem statement and current context.
2. Run `lake build` or invoke proof assistant diagnostics.
3. Validate that no `sorry` placeholders remain in production proofs.

```

- **Clear descriptions:** The agent matches your prompt against the skill's
  `description` field to decide whether to activate it.
- **Encapsulation:** Keep scripts inside `scripts/` and instruct the agent to
  run them with `--help` instead of parsing entire script implementations.

### 5. Development Loop in Practice

```text
[Prompt / Issue]
       │
       ▼
1. UNDERSTAND ──> Reads context + activates relevant skills (e.g., /lean4-proofs)
       │
       ▼
2. PLAN       ──> Formulates implementation strategy
       │
       ▼
3. MODIFY     ──> Applies code changes across Haskell, Lean 4, Python, etc.
       │
       ▼
4. MAKE       ──> Executes `make` build targets
       │
       ▼
5. TEST       ──> Runs `make test` or language runner (completion gate)
       │
       ▼
6. REVIEW     ──> Validates clean diffs and final outputs

```

- **Autonomous Invocation:** When you ask the agent to complete a task, it
  checks available skills and automatically applies matching ones based on the
  workspace language and file types.
- **Manual Slash Commands:** Force activation of any specific skill directly by
  entering `/<skill-name>` into the Antigravity prompt interface.
