default: help

.PHONY: install
install: ## Install dependencies
	@npm install

.PHONY: test
test: ## Run tests
	@npx elm-test

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
