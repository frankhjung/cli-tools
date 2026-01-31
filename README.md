# Article: Gemini and VSCode CLI Tools

This repository contains the source and build tooling for the article.

Read the article online: <https://frankhjung.github.io/cli-tools/>

## Source

Primary source file: [cli-tools.md](cli-tools.md)

## Build (Make)

Requirements:

- [pandoc](https://pandoc.org/)
- a TeX engine for PDF output, e.g.,
  [xelatex](https://www.overleaf.com/learn/latex/XeLaTeX)

Targets:

- `make` → builds HTML and PDF into `public/` directory
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
