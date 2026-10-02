# Article: Gemini and VS Code CLI Tools

This repository contains the source and build tooling for the article.

Read the article online:
[Frankly Speaking - CLI Tools](https://frankhjung.github.io/cli-tools/)

## Repository Structure

This repository contains the following main components:

- [cli-tools.md]: The primary markdown source file for the article.
- [gemini-readme.md]: Additional documentation on Gemini CLI extensions.
- [files/gemini/]: Ready-to-use assets for Gemini CLI, including template
  instructions ([GEMINI.md]), settings, [rules/], [gems/], and [skills/].
- [sync-files.sh]: A utility script to synchronise files by copying them physically into the project.
- [article.css] and [header-include.tex]: Styling and LaTeX header template
  for Pandoc HTML and PDF build output.
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
- `make install` → installs assets by copying to `~/.gemini/` and
  `~/.copilot/skills/`
- `make install-copy` → copies assets to user configuration directories
- `make install-links` → installs assets via symlinks into user directories

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

The [sync-files.sh] script is used to synchronise the local assets in the
`files/` directory with files from an Ansible AI role directory (defined in
the `MAPPINGS` variable).

It creates a physical copy of each file and directory, preserving the directory
structure without creating symlinks or hardlinks.

### Usage

Run the script from the repository root:

```bash
./sync-files.sh
```

> [!IMPORTANT]
> The destination is an independent copy, so edits are local to this project and
> do not modify the original Ansible source files.

[cli-tools.md]: cli-tools.md
[gemini-readme.md]: gemini-readme.md
[files/gemini/]: files/gemini/
[GEMINI.md]: files/gemini/GEMINI.md
[rules/]: files/gemini/rules/
[gems/]: files/gemini/gems/
[skills/]: files/gemini/skills/
[sync-files.sh]: sync-files.sh
[article.css]: article.css
[header-include.tex]: header-include.tex
[images/]: images/
