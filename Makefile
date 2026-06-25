SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

.PHONY: help
help: ## List available targets (Default)
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

DOCKER_FLAGS := --rm --interactive
STYLUA_FLAGS :=
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	# Allocate a TTY for interactive sessions so the user can abort if needed
	DOCKER_FLAGS += --tty
else
	STYLUA_FLAGS += --check
endif

SHELL_FILES := bootstrap.sh .aliases .env .functions

.PHONY: test
test: shellcheck luacheck ## Run static analyzers 

.PHONY: lint
lint: shfmt yamllint mdl stylua ## Run linters

.PHONY: shfmt
shfmt: ## Run shfmt on shell scripts
	docker run $(DOCKER_FLAGS) \
		-v "${PWD}:/mnt" --workdir /mnt \
		mvdan/shfmt:latest --diff --simplify --write $(SHELL_FILES)

.PHONY: yamllint
yamllint: ## Run yamllint on YAML files
	docker run $(DOCKER_FLAGS) \
		-v "${PWD}:/mnt:ro" --workdir /mnt \
		cytopia/yamllint:latest .

.PHONY: shellcheck
shellcheck: ## Run shellcheck on shell scripts
	docker run $(DOCKER_FLAGS) \
		-v "${PWD}:/mnt:ro" --workdir /mnt \
		koalaman/shellcheck:latest -x $(SHELL_FILES)

.PHONY: mdl
mdl: ## Run mdl on markdown files
	docker run $(DOCKER_FLAGS) \
		-v "${PWD}:/mnt:ro" --workdir /mnt \
		--platform linux/amd64 \
		markdownlint/markdownlint .

.PHONY: luacheck
luacheck: ## Run luacheck on lua files
	docker run $(DOCKER_FLAGS) \
		-v "${PWD}:/mnt:ro" --workdir /mnt \
		--platform linux/amd64 \
		ghcr.io/lunarmodules/luacheck:latest --codes .

# TODO: The docker container johnnymorganz/stylua can't be run as a standalone
# because there is no ENTRYPOINT; it is meant to be used as a part of
# other containers. This project does not currently have a global Dockerfile,
# so temporarily rely on the environment already having stylua installed into
# it. Github actions sets this up for CI and locally we can install stylua via
# brew.
.PHONY: stylua
stylua: ## Run stylua on lua files (Requires local stylua binary on $PATH)
	@stylua --version && stylua $(STYLUA_FLAGS) .
