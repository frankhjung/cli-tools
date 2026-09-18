#!/usr/bin/make

.SUFFIXES:
.SUFFIXES: .html .md .pdf

PROJECT := cli-tools
PANDOC  := pandoc
FILES   := $(CURDIR)/files

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
help: ## Show this help message
	@echo ""
	@echo "Default goal: ${.DEFAULT_GOAL}"
	@awk 'BEGIN { \
	  FS = ":.*##"; \
	  printf "\nUsage:\n"; \
	  printf "  make \033[36m<target>\033[0m\n\n"; \
	  printf "Targets:\n"; \
	} \
	/^[a-zA-Z_-]+:.*?##/ { \
	  printf "  \033[36m%-15s\033[0m %s\n", \
	    $$1, $$2; \
	}' $(MAKEFILE_LIST)

clean: ## Remove generated files
	@$(RM) -rf public

install: install-links ## Install configuration files

## Symlink every file under $(1) into $(2),
## preserving the relative directory structure.
define link-tree
	@find "$(1)" -type f | while read -r src; do \
	  rel="$${src#$(1)/}"; \
	  mkdir -p "$(2)/$$(dirname "$$rel")"; \
	  ln -sfn "$$src" "$(2)/$$rel"; \
	  echo "  $$rel"; \
	done
endef

install-links: ## Install skills via symlinks
	@echo "Linking Gemini skills..."
	@mkdir -p "$${HOME}/.gemini/config/skills"
	@ln -sfn "$(FILES)/gemini/GEMINI.md" \
	  "$${HOME}/.gemini/GEMINI.md"
	$(call link-tree,$(FILES)/gemini/skills,$${HOME}/.gemini/config/skills)
	@echo "Linking VS Code prompts..."
	@mkdir -p "$${HOME}/.config/Code/User/prompts"
	$(call link-tree,$(FILES)/code/prompts,$${HOME}/.config/Code/User/prompts)
	@echo "Linking agent skills..."
	@mkdir -p "$${HOME}/.agents/skills"
	$(call link-tree,$(FILES)/gemini/skills,$${HOME}/.agents/skills)

install-copy: ## Install skills by copying (fallback)
	@echo "Installing Gemini skills by copying..."
	@mkdir -p ~/.gemini/config/skills
	@cp -v files/gemini/GEMINI.md ~/.gemini/GEMINI.md
	@cp -vR files/gemini/skills/* ~/.gemini/config/skills/
	@echo "Installing VS Code skills by copying..."
	@mkdir -p ~/.config/Code/User/prompts
	@cp -vR files/code/prompts/* ~/.config/Code/User/prompts/
	@echo "Installing agent skills by copying..."
	@mkdir -p ~/.agents/skills/
	@cp -vR files/gemini/skills/* ~/.agents/skills/
