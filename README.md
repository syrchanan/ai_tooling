# utils

This repository is a personal grab-bag of utilities: dotfiles and shell helpers, devcontainers, AI agent configuration and workflows, and machine setup scripts. It is designed for extensibility and maintainability, with a focus on reproducible environments.

The devcontainer supports Python, R, and Julia for multi-language AI development, with optional Goose and Claude Code CLIs (opt-in via `.devcontainer/config.json`). The `dotfiles/` folder holds shell config and global agent instructions for the host machine. See below for details.

## Contents

### `dotfiles/`
Shell config and global AI agent instructions for WSL/Linux, set up via `install.sh`.

- `install.sh` — Installer; run with no flags for everything, or pick with `--bash` / `--ai` (`-h` for help). Idempotent, and backs up anything it replaces.
- `bash/loader.sh` — Sourced from `~/.bashrc`; loads every `bash/libs/*.sh` in order, then `~/.bashrc.local` if present.
- `bash/libs/` — Shell helpers and aliases (`10_tools.sh`, `20_alias.sh`).
- `ai/CLAUDE.md` — Global Claude Code preferences, symlinked to `~/.claude/CLAUDE.md` by `--ai`.

See [Dotfiles README](./dotfiles/README.md) for usage.

### `.devcontainer/`

Development container configurations for Python, R, Julia, and AI tooling.

- `Dockerfile` — Reproducible dev environment with Python, R, Julia (via juliaup), optional Goose and Claude Code CLIs, and common CLI tools. Includes user setup and shell configuration.
- `devcontainer.json` — VS Code/Positron devcontainer configuration, extensions, and environment settings for Python, R, Julia, and Goose development.
- `poststart.sh` — Post-start script to auto-install detected Python, R, and Julia dependencies for all projects in the workspace (see below for file targets).
- `config.json` — Toggles for languages and platforms (Goose, Claude Code, etc.); all default to off.

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

`dotfiles/ai/CLAUDE.md` is a working doc which contains my personal rules on agent behavior, code style, and collaboration.

### Changelog

`CHANGELOG.md` has a history of changes and updates.