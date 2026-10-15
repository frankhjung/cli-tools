# Copilot File Locations

In practice, the main locations are:

- `~/.config/Code/User/prompts/`

  - holds reusable prompt files for VS Code Chat and Copilot Chat
  - often include `.prompt.md` files
  - these are like saved prompt templates you can run manually
  - they are editor-level, not global Copilot skill definitions

- `~/.copilot/skills/`

  - this is the folder for reusable Copilot skills
  - each skill is usually a directory containing `SKILL.md` plus helpers
  - these are meant to be discovered as capabilities for Copilot/agents

- `~/.copilot/agents/`

  - for custom agent definitions or persona-style agent entries
  - separate from skills

A simple rule of thumb is:

- **Prompts** = reusable chat prompt templates in VS Code
- **Skills** = reusable capabilities for Copilot agents
- **Agents** = named agent profiles or behaviours

**Also note:** global custom instructions in VS Code are often stored under the
VS Code global storage area, not under `~/.copilot`, e.g. something like:

- `~/.config/Code/User/globalStorage/github.copilot-chat/`
