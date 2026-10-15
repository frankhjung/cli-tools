#!/usr/bin/make

SHELL := bash
.SHELLFLAGS := -euo pipefail -c
MAKEFLAGS += --warn-undefined-variables
.DELETE_ON_ERROR:

.SUFFIXES:
.SUFFIXES: .html .md .pdf

PROJECT := cli-tools
PANDOC  ?= pandoc
RSYNC   ?= rsync
RSYNC_FLAGS ?= -av --checksum

# Summary of Skill Directories:
#
# - `~/.agents/skills/`:
# The open cross-agent standard directory. Read by Copilot, Antigravity (when
# in ~), Claude, and where Omarchy installs its system skills.
#
# - `~/.copilot/skills/`:
# The dedicated personal skill folder for GitHub Copilot.
#
# - `~/.gemini/skills/`:
# The user skill store for the standalone Node Gemini CLI (gemini).
# For Antigravity, place global skills in ~/.gemini/config/skills/.

# Gemini configuration
GEMINI_SRC_DIR     := $(CURDIR)/files/gemini
GEMINI_SKILLS_SRC  := $(GEMINI_SRC_DIR)/skills
GEMINI_RULES_SRC   := $(GEMINI_SRC_DIR)/rules
GEMINI_DIR         := $(HOME)/.gemini
GEMINI_SKILLS_DIR  := $(GEMINI_DIR)/config/skills
GEMINI_RULES_DIR   := $(GEMINI_DIR)/config/rules

# Copilot configuration
COPILOT_SRC_DIR    := $(CURDIR)/files/copilot
COPILOT_SKILLS_SRC := $(COPILOT_SRC_DIR)/skills
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

.PHONY: default clean help install install-copilot install-gemini
help: ## Show this help message
	@echo ""
	@echo "Default goal: $(.DEFAULT_GOAL)"
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

# Note: rsync deliberately omits --delete so skills already present in the
# targets (e.g. from plugins) are preserved.
install: install-gemini install-copilot ## Install all configuration files

install-gemini: ## Install Gemini configuration files
	@echo "Installing Gemini files..."
	@mkdir -p "$(GEMINI_DIR)"
	@$(RSYNC) $(RSYNC_FLAGS) "$(GEMINI_SRC_DIR)/GEMINI.md" "$(GEMINI_DIR)/"
	@$(RSYNC) $(RSYNC_FLAGS) "$(GEMINI_SRC_DIR)/settings.json" "$(GEMINI_DIR)/"
	@mkdir -p "$(GEMINI_SKILLS_DIR)"
	@$(RSYNC) $(RSYNC_FLAGS) "$(GEMINI_SKILLS_SRC)/" "$(GEMINI_SKILLS_DIR)/"
	@mkdir -p "$(GEMINI_RULES_DIR)"
	@$(RSYNC) $(RSYNC_FLAGS) "$(GEMINI_RULES_SRC)/" "$(GEMINI_RULES_DIR)/"

install-copilot: ## Install Copilot skills
	@echo "Installing Copilot skills..."
	@mkdir -p "$(COPILOT_SKILLS_DIR)"
	@$(RSYNC) $(RSYNC_FLAGS) "$(COPILOT_SKILLS_SRC)/" "$(COPILOT_SKILLS_DIR)/"
