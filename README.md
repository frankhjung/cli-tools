# Article: Gemini and VSCode CLI Tools

This repository contains the source and build tooling for the article.

Read the article online: <https://frankhjung.github.io/cli-tools/>

## Repository Structure

This repository contains the following main components:

- [cli-tools.md]: The primary markdown source file for the article.
- [gemini-readme.md]: Additional documentation on Gemini CLI extensions.
- [files/gemini/]: Ready-to-use assets for Gemini CLI, including project
  instructions ([GEMINI.md]), settings, and [skills/].
- [files/code/prompts/]: Agent prompt templates for GitHub Copilot CLI / VS
  Code.
- [hardlink-files.sh]: A utility script to synchronise files via hard links.
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

## Output

- HTML: `public/index.html`
- PDF: `public/cli-tools.pdf`

## Pages

This article is published in these locations:

- <https://frankhjung.github.io/cli-tools/>
- <https://frankhjung.github.io/cli-tools/cli-tools.pdf>

See also my blog:

- <https://frankhjung.blogspot.com/>

## Hardlink Files Script (`hardlink-files.sh`)

The [hardlink-files.sh] script is used to synchronise the local assets
in the `files/` directory with files from an Ansible AI role directory
(defined in the `MAPPINGS` variable).

It creates hard links for all regular files, preserving the directory
structure. Because hard links are used:

- Both paths refer to the same inode on disk.
- Edits made to files in either directory are immediately reflected in both.
- Duplicate file storage is avoided.

### Usage

Run the script from the repository root:

```bash
./hardlink-files.sh
```

> [!IMPORTANT]
> Both the source and destination directories must reside on the same
> filesystem, as hard links cannot span across different filesystems.

[cli-tools.md]: cli-tools.md
[gemini-readme.md]: gemini-readme.md
[files/gemini/]: files/gemini/
[GEMINI.md]: files/gemini/GEMINI.md
[skills/]: files/gemini/skills/
[files/code/prompts/]: files/code/prompts/
[hardlink-files.sh]: hardlink-files.sh
[article.css]: article.css
[header-include.tex]: header-include.tex
[images/]: images/
