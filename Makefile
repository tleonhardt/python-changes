# Simple Makefile for use with a uv-based development environment
.PHONY: install
install: ## Install the virtual environment with dependencies
	@echo "🚀 Creating uv Python virtual environment"
	@uv python install 3.13
	@uv sync --python=3.13
	@echo "🚀 Installing Git pre-commit hooks locally"
	@uv run pre-commit install
	@echo "🚀 Installing Prettier using npm"
	@npm install

.PHONY: check
check: ## Run code quality tools.
	@echo "🚀 Checking lock file consistency with 'pyproject.toml'"
	@uv lock --locked
	@echo "🚀 Linting code and documentation: Running pre-commit"
	@uv run pre-commit run -a

.PHONY: format
format: ## Perform ruff formatting
	@uv run ruff format

.PHONY: lint
lint: ## Perform ruff linting
	@uv run ruff check --fix

.PHONY: jlab
jlab: ## Start Jupyter Lab
	@echo "🚀 Launching JupyterLab. Navigate to http://localhost:8888/lab"
	@uv run jupyter-lab

.PHONY: help
help:
	@uv run python -c "import re; \
	[[print(f'\033[36m{m[0]:<20}\033[0m {m[1]}') for m in re.findall(r'^([a-zA-Z_-]+):.*?## (.*)$$', open(makefile).read(), re.M)] for makefile in ('$(MAKEFILE_LIST)').strip().split()]"

.DEFAULT_GOAL := help
