---
title: "Step-by-Step Guide to Gemini CLI"
author: "Frank Jung"
---

[[_TOC_]]

This tutorial covers how to use the `gemini-cli` for coding projects, content creation, and creating specialized agents. It assumes the CLI is already installed and authenticated [[1]](#ref-1).

## Part 1: Coding Projects & IDE Integration

The `gemini-cli` runs in your terminal, making it compatible with VS Code, "Antigravity" IDEs (via terminal), or any editor that supports a command line interface [[1]](#ref-1).

### 1. Launching Context-Aware Sessions

To make the AI aware of your specific code, you must run the CLI from the project's root directory.

1. Open the integrated terminal in your IDE (e.g., VS Code).
2. Navigate to your project folder: `cd path/to/your/project` [[2]](#ref-2).
3. Start the tool:

    ```bash
    gemini
    ```

    _Why:_ This enables the `read-file` and `read-many-files` tools to access your codebase [[3]](#ref-3).

### 2. Onboarding and Code Explanation

Use the CLI to generate documentation or understand complex logic.

- **Project Summary:** Run `Explain the main components of this codebase`. The CLI will parse your file structure (e.g., `src/`, `public/`) and provide a high-level summary [[2]](#ref-2).
- **File Analysis:** Ask specific questions like `What does index.js do?` to trigger the CLI to read and explain specific files [[4]](#ref-4).
- **Performance Audits:** Ask `Analyze this repo for common performance anti-patterns`. The CLI can read multiple files to identify issues like "N+1 Queries" or "Large Frontend Bundle Size" [[5]](#ref-5).

### 3. The "ReAct" Loop (Editing and Refactoring)

The CLI operates as a "ReAct" agent, meaning it thinks, chooses a tool, acts, and then responds [[6]](#ref-6).

- **Fixing Bugs:** You can paste external contexts, such as GitHub issues, to generate fixes.
  - _Prompt:_ `Here's a GitHub issue: [@search https://github.com/url/issue]. Analyze the code and suggest a fix.`
  - The CLI will analyze the issue, plan a fix, and can use the `edit` tool to apply changes via diffs if you approve them [[7]](#ref-7), [[3]](#ref-3).
- **Shell Integration:** Run terminal commands without leaving the session by prefixing with `!`.
  - _Example:_ `!npm test` or `!ls -al` [[4]](#ref-4).

---

## Part 2: Non-Coding Projects (Blogs & Podcasts)

The CLI supports multimodal inputs (images/PDFs) and web connectivity, making it powerful for research and content creation [[6]](#ref-6).

### 1. Research with "Grounding"

Avoid hallucinations by forcing the CLI to fetch real-world data.

- **Web Search:** Use `@search` or the `google_web_search` tool to find current information [[3]](#ref-3).
- **Content Fetching:** Use `web-fetch` to retrieve content from URLs for summarization.
  - _Prompt:_ `Fetch this URL [insert link] and summarize the key points for a podcast script` [[3]](#ref-3).

### 2. Drafting Content

- **Writing:** Ask the CLI to generate prose directly.
  - _Example:_ `Write a blog post intro about the benefits of local LLMs` [[8]](#ref-8).
- **Multimodal Tasks:** The CLI can process images or PDFs. You can prompt it to "Summarize this PDF" or "Generate a blog caption based on this image" [[6]](#ref-6).

### 3. Saving Your Work

- **Write to Disk:** Use the `write-file` tool to save your drafts immediately.
  - _Command:_ `Create a new file named podcast_draft.md with the summary you just generated` [[3]](#ref-3).

---

## Part 3: Setting Up Specialized Agents

You can configure `gemini-cli` to act as a specialized agent (e.g., "Senior Editor" or "DevOps Engineer") using configuration files and the Model Context Protocol (MCP).

### 1. Defining Agent Persona (`GEMINI.md`)

To create a persistent context for a specific project, create a `GEMINI.md` file in the project root [[9]](#ref-9).

- **Action:** Create a file named `GEMINI.md`.
- **Content:** specific rules, such as "Always write code in TypeScript," "Use a casual tone for blog posts," or "Prefer async/await patterns."
- **Result:** Every session launched in this folder will automatically ingest these rules, creating a consistent "agent" experience.

### 2. Extending Capabilities with MCP

You can connect the CLI to external services (like GitHub, Google Drive, or Databases) using MCP Servers [[10]](#ref-10).

#### Example: Setting up a GitHub Agent

1. Create a configuration directory:

    ```bash
    mkdir -p .gemini && touch .gemini/settings.json
    ```

2. Add the MCP server configuration to `settings.json` [[11]](#ref-11):

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

3. **Activate:** Restart the CLI (`/quit` then `gemini`).
4. **Verify:** Type `/mcp` to see the new tools. Your agent can now "Create issues" or "Check PRs" directly [[11]](#ref-11).

### 3. Persistent Memory

Use the `save_memory` tool (or `memoryTool`) to store facts during a session. This allows the agent to remember user preferences across different interactions within the session [[3]](#ref-3), [[12]](#ref-12).

## References

The following sources were used to compile the Gemini CLI tutorial:

### ref-1

**[Beginner's Guide to Gemini CLI: Install, Setup, and Use It Like a Pro](https://www.kdnuggets.com)** - KDnuggets, Kanwal Mehreen. Provided IDE integration and installation guidance.

### ref-2

**[Beginner's Guide to Gemini CLI](https://www.kdnuggets.com)** - KDnuggets. Project navigation and code explanation workflows.

### ref-3

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)** - ProfLead.dev, Vladislav Guzey. Built-in tools documentation (`read-file`, `write-file`, `web-fetch`, `google_web_search`).

### ref-4

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)** - ProfLead.dev. File analysis and shell integration features.

### ref-5

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)** - ProfLead.dev. Performance audit capabilities.

### ref-6

**[Gemini CLI Full Tutorial](https://proflead.dev/posts/gemini-cli-tutorial/)** - ProfLead.dev. ReAct agent loop and multimodal input support.

### ref-7

**[Gemini CLI Documentation](https://github.com/google-gemini/gemini-cli)** - Official Documentation. Edit tool and diff-based code changes.

### ref-8

**[Gemini CLI Documentation](https://github.com/google-gemini/gemini-cli)** - Official Documentation. Content generation capabilities.

### ref-9

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)** - GitHub. GEMINI.md context file configuration.

### ref-10

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)** - GitHub. MCP Server integration.

### ref-11

**[google-gemini/gemini-cli GitHub Repository](https://github.com/google-gemini/gemini-cli)** - GitHub. MCP settings.json configuration examples.

### ref-12

**[Gemini CLI Full Tutorial](https://dev.to/proflead/gemini-cli-full-tutorial-2ab5)** - DEV Community, Vladislav Guzey. Memory tool (`save_memory`, `memoryTool`) for persistent session data.
