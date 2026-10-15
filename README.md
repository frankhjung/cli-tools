# Article: Gemini and VS Code CLI Tools

This repository contains the source and build tooling for the article.

Read the article online:
[Frankly Speaking - CLI Tools](https://frankhjung.github.io/cli-tools/)

## Repository Structure

This repository contains the following main components:

- [cli-tools.md]: The primary markdown source file for the article.
- [gemini-readme.md]: Additional documentation on Gemini CLI extensions.
- [SKILLS.md]: Quick-start guide for installing and managing Agent Skills.
- [files/gemini/]: Ready-to-use assets for Gemini CLI, including template
  instructions ([GEMINI.md]), settings, [rules/], [gems/], and [skills/].
- [files/copilot/]: Dedicated GitHub Copilot skills ([files/copilot/skills/])
  managed directly in this repository. See
  [Copilot File Locations](files/copilot/README.md).
- [sync-files.sh]: A utility script to synchronise files by copying them
  physically into the project.
- [article.css] and [header-include.tex]: Styling and LaTeX header template for
  Pandoc HTML and PDF build output.
- [images/]: Image assets included in the article.

## Build (Make)

Requirements:

- [pandoc](https://pandoc.org/)
- A TeX engine for PDF output, e.g.,
  [xelatex](https://www.overleaf.com/learn/latex/XeLaTeX)

Targets:

- `make` → builds HTML and PDF into the `public/` directory
- `make clean` → removes the `public/` directory
- `make help` → displays available Makefile targets
- `make install` → installs all Gemini and Copilot configuration files via rsync
- `make install-gemini` → installs Gemini configuration, rules, and skills to
  `~/.gemini/`
- `make install-copilot` → installs Copilot skills to `~/.copilot/skills/`

## Output

- HTML: `public/index.html`
- PDF: `public/cli-tools.pdf`

## Pages

This article is published in these locations:

- [HTML Version](https://frankhjung.github.io/cli-tools/)
- [PDF Version](https://frankhjung.github.io/cli-tools/cli-tools.pdf)

See also my blog:

- [Frankly Speaking](https://frankhjung.blogspot.com/)

## Copy Files Script (`sync-files.sh`)

The [sync-files.sh] script is used to synchronise local Gemini assets in
`files/gemini/` with files from an Ansible AI role directory (defaulting to
`~/dev/ansible/debian/roles/antigravity/files`). Copilot files in
`files/copilot/` are managed directly within this repository.

It creates a physical copy of each file and directory, preserving the directory
structure without creating symlinks or hardlinks.

### Usage

Run the script from the repository root (optionally specifying an alternative
source directory via `SYNC_SRC_BASE`):

```bash
./sync-files.sh
# or specify the gemini skills src directory:
SYNC_SRC_BASE=/path/to/role/files ./sync-files.sh
```

> [!IMPORTANT] The destination is an independent copy, so edits are local to
> this project and do not modify the original Ansible source files.

[cli-tools.md]: cli-tools.md
[gemini-readme.md]: gemini-readme.md
[SKILLS.md]: SKILLS.md
[files/gemini/]: files/gemini/
[files/copilot/]: files/copilot/
[files/copilot/skills/]: files/copilot/skills/
[GEMINI.md]: files/gemini/GEMINI.md
[rules/]: files/gemini/rules/
[gems/]: files/gemini/gems/
[skills/]: files/gemini/skills/
[sync-files.sh]: sync-files.sh
[article.css]: article.css
[header-include.tex]: header-include.tex
[images/]: images/
