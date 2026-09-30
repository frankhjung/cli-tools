#!/usr/bin/make

.SUFFIXES:
.SUFFIXES: .html .md .pdf

PROJECT := cli-tools
PANDOC  ?= pandoc
SRC_DIR := $(CURDIR)/files/gemini
SKILLS_SRC := $(SRC_DIR)/skills
GEMINI_DIR := $(HOME)/.gemini
GEMINI_SKILLS_DIR := $(GEMINI_DIR)/skills
COPILOT_SKILLS_DIR := $(HOME)/.copilot/skills

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

install: install-copy ## Install configuration files

install-copy: ## Install skills by copying (default)
	@echo "Installing Gemini files by copying..."
	@mkdir -p "$(GEMINI_DIR)"
	@cp -v "$(SRC_DIR)/GEMINI.md" "$(GEMINI_DIR)/"
	@cp -v "$(SRC_DIR)/settings.json" "$(GEMINI_DIR)/"
	@mkdir -p "$(GEMINI_SKILLS_DIR)"
	@cp -vR "$(SKILLS_SRC)"/* "$(GEMINI_SKILLS_DIR)/"
	@echo "Installing Copilot skills by copying..."
	@mkdir -p "$(COPILOT_SKILLS_DIR)"
	@cp -vR "$(SKILLS_SRC)"/* "$(COPILOT_SKILLS_DIR)/"

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
	@echo "Linking Gemini files..."
	@mkdir -p "$(GEMINI_DIR)"
	@ln -sfn "$(SRC_DIR)/GEMINI.md" "$(GEMINI_DIR)/GEMINI.md"
	@ln -sfn "$(SRC_DIR)/settings.json" "$(GEMINI_DIR)/settings.json"
	@mkdir -p "$(GEMINI_SKILLS_DIR)"
	$(call link-tree,$(SKILLS_SRC),$(GEMINI_SKILLS_DIR))
	@echo "Linking Copilot skills..."
	@mkdir -p "$(COPILOT_SKILLS_DIR)"
	$(call link-tree,$(SKILLS_SRC),$(COPILOT_SKILLS_DIR))
