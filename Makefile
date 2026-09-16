#!/usr/bin/make

.SUFFIXES:
.SUFFIXES: .html .md .pdf

PROJECT:= cli-tools
PANDOC := pandoc

default: $(PROJECT).html $(PROJECT).pdf

.md.html:
	@mkdir -p public
	@$(PANDOC) \
		--from=gfm --to html5 \
		--embed-resources --standalone --css article.css \
		--output public/$@ \
		$<
	@mv public/$@ public/index.html

.md.pdf:
	@mkdir -p public
	@$(PANDOC) \
		--include-in-header header-include.tex \
		--from=markdown --pdf-engine=xelatex \
		--css article.css \
		--toc \
		--output public/$@ \
		$<

.PHONY: clean install
clean:
	@$(RM) -rf public

install:
	# Gemini
	@mkdir -p ~/.gemini/config/skills
	@cp -v files/gemini/GEMINI.md ~/.gemini/GEMINI.md
	@cp -vR files/gemini/skills/* ~/.gemini/config/skills/
	# VS Code
	@mkdir -p ~/.config/Code/User/prompts
	@cp -vR files/code/prompts/* ~/.config/Code/User/prompts/
	@mkdir -p ~/.agents/skills/
	@cp -vR files/gemini/skills/* ~/.agents/skills/
