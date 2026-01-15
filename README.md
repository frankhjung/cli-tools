---
title: "Step-by-Step Guide to Gemini CLI"
author: "Frank Jung"
---

[[_TOC_]]

This tutorial covers how to use the `gemini-cli` for coding projects, content
creation, and creating specialized agents. It assumes the CLI is already
installed and authenticated [[1]](#ref-1).

## Part 1: Coding Projects & IDE Integration

The `gemini-cli` runs in your terminal, making it compatible with VS Code,
Google's [AntiGravity](https://antigravity.google/) IDEs (via terminal), or any
editor that supports command-line interfaces [[1]](#ref-1).

### 1. Launching Context-Aware Sessions

To make the AI aware of your specific code, you must run the CLI from the
project's root directory.

1. Open the integrated terminal in your IDE (e.g., VS Code).
2. Navigate to your project folder: `cd path/to/your/project` [[2]](#ref-2).
3. Start the tool:

```bash
gemini
```

_Why?_ This enables the `read-file` and `read-many-files` tools to access your
codebase [[3]](#ref-3).

### 2. Onboarding and Code Explanation

Use the CLI to generate documentation or understand complex logic.

- **Project Summary:** Run `Explain the main components of this codebase`. The
  CLI will parse your file structure (e.g., `src/`, `public/`) and provide a
  high-level summary [[2]](#ref-2).
- **File Analysis:** Ask specific questions like `What does index.js do?` to
  trigger the CLI to read and explain specific files [[4]](#ref-4).
- **Performance Audits:** Ask
  `Analyze this repo for common performance anti-patterns`. The CLI can read
  multiple files to identify issues like "N+1 Queries" or "Large Frontend Bundle
  Size" [[5]](#ref-5).

### 3. The "ReAct" Loop (Editing and Refactoring)

The CLI operates as a "ReAct" agent, meaning it thinks, chooses a tool, acts,
and then responds [[6]](#ref-6).

- **Fixing Bugs:** You can paste external contexts, such as GitHub issues, to
  generate fixes.
  - _Prompt:_
    `Here's a GitHub issue: [@search https://github.com/url/issue]. Analyze the code and suggest a fix.`
  - The CLI will analyze the issue, plan a fix, and can use the `edit` tool to
    apply changes via diffs if you approve them [[7]](#ref-7), [[3]](#ref-3).
- **Shell Integration:** Run terminal commands without leaving the session by
  prefixing with `!`.
  - _Example:_ `!npm test` or `!ls -al` [[4]](#ref-4).

## Part 2: Non-Coding Projects (Blogs & Podcasts)

The CLI supports multimodal inputs (images/PDFs) and web connectivity, making it
powerful for research and content creation [[6]](#ref-6).

### 1. Research with "Grounding"

Avoid hallucinations by forcing the CLI to fetch real-world data.

- **Web Search:** Use `@search` or the `google_web_search` tool to find current
  information [[3]](#ref-3).
- **Content Fetching:** Use `web-fetch` to retrieve content from URLs for
  summarization.
  - _Prompt:_
    `Fetch this URL [insert link] and summarize the key points for a podcast script`
    [[3]](#ref-3).

### 2. Drafting Content

- **Writing:** Ask the CLI to generate prose directly.
  - _Example:_ `Write a blog post intro about the benefits of local LLMs`
    [[8]](#ref-8).
- **Multimodal Tasks:** The CLI can process images or PDFs. You can prompt it to
  "Summarize this PDF" or "Generate a blog caption based on this image"
  [[6]](#ref-6).

### 3. Saving Your Work

- **Write to Disk:** Use the `write-file` tool to save your drafts immediately.
  - _Command:_
    `Create a new file named podcast_draft.md with the summary you just generated`
    [[3]](#ref-3).

## Part 3: Setting Up Specialized Agents

You can configure `gemini-cli` to act as a specialized agent (e.g., "Senior
Editor" or "DevOps Engineer") using configuration files and the Model Context
Protocol (MCP).

### 1. Defining Agent Persona (`GEMINI.md`)

To create a persistent context for a specific project, create a `GEMINI.md` file
in the project root [[9]](#ref-9).

- **Action:** Create a file named `GEMINI.md`.
- **Content:** Specific rules, such as "Always write code in TypeScript," "Use a
  casual tone for blog posts," or "Prefer async/await patterns."
- **Result:** Every session launched in this folder will automatically ingest
  these rules, creating a consistent "agent" experience.

### 2. Extending Capabilities with MCP

You can connect the CLI to external services (like GitHub, Google Drive, or
Databases) using MCP Servers [[10]](#ref-10).

#### Example: Setting up a GitHub Agent

- Create a configuration directory:

  ```bash
  mkdir -p .gemini && touch .gemini/settings.json
  ```

- Add the MCP server configuration to `settings.json` [[11]](#ref-11):

  ```json
    {
      "mcpServers": {
        "github": {
          "command": "npx",
          "args": ["-y", "@modelcontextprotocol/server-github"],
          "env": {
            "GITHUB_PERSONAL_ACCESS_TOKEN": "[YOUR-TOKEN]"
          }
        }
      }
    }
  ```

- **Activate:** Restart the CLI (`/quit` then `gemini`).
- **Verify:** Type `/mcp` to see the new tools. Your agent can now "Create
  issues" or "Check PRs" directly [[11]](#ref-11).

### 3. Persistent Memory

Use the `save_memory` tool (or `memoryTool`) to store facts during a session.
This allows the agent to remember user preferences across different interactions
within the session [[3]](#ref-3), [[12]](#ref-12).

## Part 4: Next Steps & Further Reading

### 1. Agents

This section explores the use of specialized agents with `gemini-cli`, drawing
parallels with existing agent platforms like Copilot Agents. Look at
[agents/](agents/) for pre-built [agent
personas](https://docs.github.com/en/copilot/how-tos/use-copilot-agents) you can
use as templates.

These examples are for Copilot Agents, but the same principles apply to Gemini
CLI agents. These agents should be copied to your `~/.config/Code/User/prompts`
folder for use with VS Code.

### 2. Gemini

#### 2.1 [Gemini README](../gemini-readme.md)

#### 2.2 [Gemini Slash Commands](https://geminicli.com/docs/cli/commands/)

### 3. Other tools and Integrations

- Experiment with different agent personas by modifying `GEMINI.md`.
- Explore additional MCP Servers for more integrations.
- Use Google's [Code Wiki](https://codewiki.google/) for documentation.
- Look at [extensions](https://geminicli.com/extensions/). Or from Gemini CLI
  invoke:

  ```bash
  /extensions explore
  ```

  For example, to run a documentation review agent on this README file:

  ```bash
  copilot-cli agents run documentation-reviewer README.md
  ```

### 4. Other Resources

#### Gemini

This series by [Romin Irani](https://iromin.medium.com/) is a more comprehensive
guide to Gemini CLI: [Gemini CLI Tutorial
Series](https://medium.com/google-cloud/gemini-cli-tutorial-series-77da7d494718).

Also look at the official Gemini CLI tutorials: [Gemini CLI
Tutorials](https://geminicli.com/docs/cli/tutorials/).

##### Gemini Skills

###### [Skill Discovery Tiers](https://geminicli.com/docs/cli/skills/)

Gemini CLI discovers skills from three primary locations:

1. **Project Skills** (`.gemini/skills/`): Project-specific skills that are
   typically committed to version control and shared with the team.
1. **User Skills** (`~/.gemini/skills/`): Personal skills available across all
   your projects. Extension Skills: Skills bundled within installed extensions
1. **Extension Skills**: Skills bundled within installed extensions

**Precedence:** If multiple skills share the same name, higher-precedence
locations override lower ones: `Project > User > Extension`.

#### Copilot

##### Copilot Skills

[Claude Skills](https://code.claude.com/docs/en/skills) is an open standard and
can be used by Copilot Agents as well. See this
[announcement](https://github.blog/changelog/2025-12-18-github-copilot-now-supports-agent-skills/).

For examples look at:

- [github.com/obra/superpowers](https://github.com/obra/superpowers)
- Can use Anthropic (Claude) Skills: https://github.com/anthropics/skills
  GitHub’s community: https://github.com/github/awesome-copilot

For more details see
[Copilot: about agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills?utm_source=docs&utm_medium=&utm_campaign=skills-25)

Copilot supports: Project skills, stored in your repository (`.github/skills` or
`.claude/skills`) Personal skills, stored in your home directory and shared
across projects (`~/.copilot/skills` or `~/.claude/skills`)

I'd recommend starting with the
[README](https://github.com/github/awesome-copilot/blob/main/README.md)

###### Agents-Skills

- [devops-expert.agent](https://github.com/github/awesome-copilot/blob/main/agents/devops-expert.agent.md)
- [janitor.agent](https://github.com/github/awesome-copilot/blob/main/agents/janitor.agent.md)
- [Thinking-Beast-Mode.agent](https://github.com/github/awesome-copilot/blob/main/agents/Thinking-Beast-Mode.agent.md)
- [clojure-interactive-programming.agent](https://github.com/github/awesome-copilot/blob/main/agents/clojure-interactive-programming.agent.md)
- [mentor.agent](https://github.com/github/awesome-copilot/blob/main/agents/mentor.agent.md)

###### Instructions

Start with these
[instructions](https://github.com/github/awesome-copilot/blob/main/instructions/instructions.instructions.md).

- [clojure.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/clojure.instructions.md)
- [code-review-generic.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/code-review-generic.instructions.md)
- [devops-core-principles.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/devops-core-principles.instructions.md)
- [makefile.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/makefile.instructions.md)
- [markdown.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/markdown.instructions.md)
- [python.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/python.instructions.md)
- [r.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/r.instructions.md)
- [shell.instructions.md](https://github.com/github/awesome-copilot/blob/main/instructions/shell.instructions.md)

## References

The following sources were used to compile the Gemini CLI tutorial:

### ref-1

**[Beginner's Guide to Gemini CLI: Install, Setup, and Use It Like a
Pro](https://www.kdnuggets.com)** - KDnuggets, Kanwal Mehreen. Covers IDE
integration and installation guidance.

### ref-2

**[Beginner's Guide to Gemini CLI](https://www.kdnuggets.com)** - KDnuggets.
Project navigation and code explanation workflows.

### ref-3

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)**

- ProfLead.dev, Vladislav Guzey. Built-in tools documentation (`read-file`,
  `write-file`, `web-fetch`, `google_web_search`).

### ref-4

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)**

- ProfLead.dev. File analysis and shell integration features.

### ref-5

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)**

- ProfLead.dev. Performance audit capabilities.

### ref-6

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)**

- ProfLead.dev. ReAct agent loop and multimodal input support.

### ref-7

**[Gemini CLI Documentation](https://github.com/google-gemini/gemini-cli)**

- Official Documentation. Edit tool and diff-based code changes.

### ref-8

**[Gemini CLI Documentation](https://github.com/google-gemini/gemini-cli)**

- Official Documentation. Content generation capabilities.

### ref-9

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)**

- GitHub. GEMINI.md context file configuration.

### ref-10

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)**

- GitHub. MCP Server integration.

### ref-11

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)**

- GitHub. MCP settings.json configuration examples.

### ref-12

**[Gemini CLI Full Tutorial](https://dev.to/proflead/gemini-cli-full-tutorial-2ab5)**

- DEV Community, Vladislav Guzey. Memory tool (`save_memory`, `memoryTool`) for
  persistent session data.
