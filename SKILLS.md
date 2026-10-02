# Agent Skills Quick-Start Guide

Agent skills provide modular, procedural runbooks that extend the capabilities
of coding assistants such as Gemini CLI, Antigravity, and Claude Code. Skills
adhere to an open standard using a `SKILL.md` file with YAML front matter and
step-by-step instructions.

---

## Prerequisites and Installation

On modern Linux environments running current Node.js releases (Node 20+), an
outdated standalone `npx` binary in `/usr/local/bin` may cause callback errors
due to legacy `npm@5` dependencies. To ensure the modern bundled runner is
executed, call `/usr/bin/npx -y` directly or ensure `/usr/local/bin/npx` has
been removed.

### Installing Google Skills

To install the official [Google Skills](https://github.com/google/skills)
repository (covering Vertex AI, Google Cloud, and Gemini development patterns),
run:

```bash
/usr/bin/npx -y skills add https://github.com/google/skills
```

### Installation Scopes

You can install skills into your current workspace or globally across all
projects on your machine:

- **Project Scope (Default):** Installs skills into `.agents/skills/` in your
  repository root. Commit these to version control to share them with your
  team.
- **Global Scope (`-g`):** Installs skills into your user configuration
  directory (`~/.gemini/config/skills/`), making them available across every
  workspace:

```bash
/usr/bin/npx -y skills add -g https://github.com/google/skills
```

---

## Interactive Skill Selection and Discovery

When importing repositories that provide multiple skills, you can explore and
select skills interactively rather than installing the entire suite.

### Interactive Selection During Installation

When you run `skills add` without specifying `--skill` or `--all`, the CLI
presents an interactive checklist:

```bash
/usr/bin/npx -y skills add https://github.com/google/skills
```

Use the arrow keys to navigate, the spacebar to toggle desired skills, and
press Enter to install the selected subset.

### Interactive Search

To search the global [skills.sh](https://skills.sh) registry for available
skills interactively:

```bash
/usr/bin/npx -y skills find
```

You can also filter by keyword or specific repository owners:

```bash
# Search for keyword interactively
/usr/bin/npx -y skills find vertex

# Search repositories by owner
/usr/bin/npx -y skills find --owner google
```

### Previewing Available Skills Before Installing

To inspect every skill provided by a remote repository without writing any
files to disk:

```bash
/usr/bin/npx -y skills add --list https://github.com/google/skills
```

---

## Common Tasks and Management

### Installing Specific Skills Directly

To skip interactive menus and install one or more specific skills by name:

```bash
/usr/bin/npx -y skills add --skill retrieving-developer-knowledge \
  https://github.com/google/skills
```

### Listing Installed Skills

Inspect which skills are currently registered in your environment:

```bash
# List skills in the current project
/usr/bin/npx -y skills list

# List globally installed skills
/usr/bin/npx -y skills list -g
```

### Updating Installed Skills

Keep your installed skills synchronised with upstream updates:

```bash
# Update skills in the current project
/usr/bin/npx -y skills update

# Update globally installed skills
/usr/bin/npx -y skills update -g
```

### Removing Skills

Remove skills that are no longer required:

```bash
# Interactive removal menu
/usr/bin/npx -y skills remove

# Remove a specific skill by name from the project
/usr/bin/npx -y skills remove retrieving-developer-knowledge

# Remove a globally installed skill
/usr/bin/npx -y skills rm -g retrieving-developer-knowledge
```

### Testing a Skill Without Installing

Generate prompt instructions for a skill on demand without saving it to disk:

```bash
/usr/bin/npx -y skills use \
  https://github.com/google/skills@retrieving-developer-knowledge
```

---

## How Agents Use Skills

Agent skills rely on **progressive disclosure** to conserve context window
tokens:

1. **Discovery:** When a session starts, the agent loads only the name and
   description from each skill's YAML front matter.
2. **Autonomous Triggering:** When your prompt requests a task that matches a
   skill description (for example, "Help me troubleshoot Google Cloud IAM
   permissions"), the agent reads the full `SKILL.md` runbook automatically.
3. **Manual Invocation:** You can also explicitly invoke any installed skill by
   typing its slash command directly into the prompt panel:

```text
/retrieving-developer-knowledge
```

---

## Skill Directory Structure

Each installed skill creates a self-contained directory adhering to the
following layout:

```text
skills/<skill-name>/
├── SKILL.md          # Required: Instructions with YAML front matter
├── scripts/          # Optional: Executable automation and helper scripts
├── examples/         # Optional: Code snippets and reference samples
├── resources/        # Optional: Templates, assets, or configuration files
└── references/       # Optional: In-depth documentation and manuals
```
