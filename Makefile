SHELL := /usr/bin/env bash

.PHONY: install clean help

.DEFAULT_GOAL := help

help: ## List available targets (Default)
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

DOTFILE_LIST ?= $(shell find $(CURDIR) -type f -name ".*" -maxdepth 1 -not -name ".gitignore")

install: ## Install dotfiles to $HOME
	@for dotfile in $(DOTFILE_LIST); do ln -svF $$dotfile ~/$$(basename $$dotfile); done;

clean: ## Uninstall dotfiles from $HOME
	@for dotfile in $(DOTFILE_LIST); do unlink -- ~/$$(basename $$dotfile); done;
