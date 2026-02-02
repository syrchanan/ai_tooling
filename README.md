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
`config.json` — Configuration for language and platform support.

See [Devcontainer README](./.devcontainer/README.md) for more details.

### `ralph/`
Agent workflow scripts and Goose recipes for iterative, cross-model development. Based on the [tutorial at goose](https://block.github.io/goose/docs/tutorials/ralph-loop).

- `ralph-loop.sh` — Bash script to run the Ralph Loop (multi-model, iterative agent workflow with review and feedback).
- `ralph-work.yaml` — Goose recipe for the work phase (single iteration, fresh context, state via files).
- `ralph-review.yaml` — Goose recipe for the review phase (cross-model review, SHIP/REVISE decision).

#### Ralph Loop

The Ralph Loop enables iterative agent development with strict review, using different models for work and review phases. Each iteration is stateless (fresh context), and the workflow is managed via state files in `.goose/ralph/`. The loop continues until the reviewer ships the work or the max iteration count is reached.

- Usage: `./ralph-loop.sh "your task description"` or `./ralph-loop.sh /path/to/task.md`
- Environment variables allow customization of models, providers, and iteration limits.
- See `ralph-loop.sh` for details.

### Agent Rules

`.github/AGENTS.md` is a working doc which contains my personal rules on agent behavior, code style, naming, and collaboration.

### Changelog

`CHANGELOG.md` has a history of changes and updates.