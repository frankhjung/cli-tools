#!/usr/bin/make

.SUFFIXES:
.SUFFIXES: .html .md .pdf

PROJECT:= cli-tools
PANDOC := pandoc

default: $(PROJECT).html $(PROJECT).pdf

.md.html: ## Convert Markdown to HTML
	@mkdir -p public
	$(PANDOC) \
		--from=gfm --to html5 \
		--embed-resources --standalone --css article.css \
		--output public/$@ \
		$<
	@mv public/$@ public/index.html

.md.pdf: ## Convert Markdown to PDF
	@mkdir -p public
	$(PANDOC) \
		--include-in-header header-include.tex \
		--from=markdown --pdf-engine=xelatex \
		--css article.css \
		--toc \
		--output public/$@ \
		$<

.PHONY: clean help install
help: ## Show this help message
	@echo ""
	@echo "Default goal: ${.DEFAULT_GOAL}"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
clean: ## Remove generated files
	@$(RM) -rf public

install: ## Install configuration files for Gemini and VS Code
	@echo Install Gemini skills...
	@mkdir -p ~/.gemini/config/skills
	@cp -v files/gemini/GEMINI.md ~/.gemini/GEMINI.md
	@cp -vR files/gemini/skills/* ~/.gemini/config/skills/
	@echo Install VS Code skills...
	@mkdir -p ~/.config/Code/User/prompts
	@cp -vR files/code/prompts/* ~/.config/Code/User/prompts/
	@mkdir -p ~/.agents/skills/
	@cp -vR files/gemini/skills/* ~/.agents/skills/
