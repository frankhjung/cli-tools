# Gemini README

This document contains Gemini CLI specific information and instructions.

## Extensions

There is not a specific command to list installed Gemini extensions. You
can see your installed extensions by listing the contents of the
`~/.gemini/commands/` directory. Each `.toml` file in that directory
represents an extension.

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
