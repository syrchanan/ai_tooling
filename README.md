# AI Tooling

This repository is a personal hub for AI development tools, prompts, devcontainers, and agent configuration. It is designed for extensibility and maintainability, with a focus on reproducible development environments and agent behavior customization.

The devcontainer now supports Python, R, and Julia for multi-language AI development. Goose CLI is included for seamless agent authentication. See below for details.

## Contents

### `.github/`
Custom add-ons and global instructions for AI agents.

- `chatmodes/` — Custom chat modes for agents
- `instructions/` — Custom agent instructions
- `prompts/` — Custom prompt templates
- `AGENTS.md` — Global agent rules and collaboration standards

### `.devcontainer/`

Development container configurations for Python, R, Julia, and AI tooling.

- `Dockerfile` — Reproducible dev environment with Python, R, Julia (via juliaup), Goose CLI, and common CLI tools. Includes user setup, shell configuration, and health checks.
- `devcontainer.json` — VS Code/Positron devcontainer configuration, extensions, and environment settings for Python, R, Julia, and Goose development.
- `poststart.sh` — Post-start script to auto-install detected Python, R, and Julia dependencies for all projects in the workspace (see below for file targets).

## Devcontainer Features

- Python (latest, Debian-based)
- R (latest)
- Julia (latest, via juliaup)
- Goose CLI (installed and on PATH)
- Common dev tools: git, curl, vim, htop, tree, ripgrep, etc.
- Preinstalled Python packages: pytest, ipython, requests, python-dotenv
- Custom shell environment for developer user
- Health check script and welcome banner (shows Python, R, Julia, Goose versions)
- VS Code/Positron extensions for Python, R, Julia, linting, formatting, and Jupyter

## Agent Rules

`.github/AGENTS.md` is a working doc which contains my personal rules on agent behavior, code style, naming, and collaboration.

## `.devcontainer/poststart.sh`

Post-start script that auto-installs Python, R, and Julia dependencies recursively for all projects in the workspace:

- Installs Python packages from `requirements.txt` and `pyproject.toml` using `uv`
- Restores R environments from `renv.lock` using `renv`
- Instantiates Julia environments from `Project.toml`

This script is run automatically after the container starts.

## Changelog

`CHANGELOG.md` has a history of changes and updates.