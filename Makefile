default: help

.PHONY: install
install: ## Install dependencies
	@npm install

.PHONY: build
build: ## Build project
	@npx parcel build src/index.html

.PHONY: cs
cs: ## Check and fix coding style issues
	@npx elm-format src/ tests/ --yes

.PHONY: dev
dev: ## Build project and launch development server
	@npx parcel src/index.html

.PHONY: test
test: ## Run tests
	@npx elm-test

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
