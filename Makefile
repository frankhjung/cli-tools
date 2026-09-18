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

.PHONY: clean help install install-links install-copy
.ONESHELL: help
help: ## Show this help message
	@echo ""
	@echo "Default goal: ${.DEFAULT_GOAL}"
	@awk -f - $(MAKEFILE_LIST) <<-'AWK'
	BEGIN {
	  FS = ":.*##"
	  printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"
	}
	/^[a-zA-Z_-]+:.*?##/ {
	  printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2
	}
	AWK

clean: ## Remove generated files
	@$(RM) -rf public

install: install-links ## Install configuration files

install-links: ## Install configuration files for Gemini and VS Code via symlinks
	@echo Install Gemini skills via symlinks...
	@mkdir -p "$${HOME}/.gemini/config/skills"
	@ln -sfn "$(CURDIR)/files/gemini/GEMINI.md" "$${HOME}/.gemini/GEMINI.md"
	@find "$(CURDIR)/files/gemini/skills" -type f -print0 | while IFS= read -r -d '' src; do \
		rel="$${src#"$(CURDIR)/files/gemini/skills/"}"; \
		mkdir -p "$${HOME}/.gemini/config/skills/$$(dirname "$$rel")"; \
		ln -sfn "$$src" "$${HOME}/.gemini/config/skills/$$rel"; \
		echo "Linked $${HOME}/.gemini/config/skills/$$rel -> $$src"; \
	done
	@echo Install VS Code skills via symlinks...
	@mkdir -p "$${HOME}/.config/Code/User/prompts"
	@find "$(CURDIR)/files/code/prompts" -type f -print0 | while IFS= read -r -d '' src; do \
		rel="$${src#"$(CURDIR)/files/code/prompts/"}"; \
		mkdir -p "$${HOME}/.config/Code/User/prompts/$$(dirname "$$rel")"; \
		ln -sfn "$$src" "$${HOME}/.config/Code/User/prompts/$$rel"; \
		echo "Linked $${HOME}/.config/Code/User/prompts/$$rel -> $$src"; \
	done
	@mkdir -p "$${HOME}/.agents/skills"
	@find "$(CURDIR)/files/gemini/skills" -type f -print0 | while IFS= read -r -d '' src; do \
		rel="$${src#"$(CURDIR)/files/gemini/skills/"}"; \
		mkdir -p "$${HOME}/.agents/skills/$$(dirname "$$rel")"; \
		ln -sfn "$$src" "$${HOME}/.agents/skills/$$rel"; \
		echo "Linked $${HOME}/.agents/skills/$$rel -> $$src"; \
	done

install-copy: ## Install configuration files by copying (fallback)
	@echo Install Gemini skills by copying...
	@mkdir -p ~/.gemini/config/skills
	@cp -v files/gemini/GEMINI.md ~/.gemini/GEMINI.md
	@cp -vR files/gemini/skills/* ~/.gemini/config/skills/
	@echo Install VS Code skills by copying...
	@mkdir -p ~/.config/Code/User/prompts
	@cp -vR files/code/prompts/* ~/.config/Code/User/prompts/
	@mkdir -p ~/.agents/skills/
	@cp -vR files/gemini/skills/* ~/.agents/skills/
