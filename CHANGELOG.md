# Changelog

All notable changes to this project will be documented in this file (via AI, minimally reviewed by a human).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2026-01-12
### Added
- `.devcontainer/poststart.sh`: Post-start script to auto-install detected Python, R, and Julia dependencies for all projects in the workspace.

### Changed
- `.devcontainer/Dockerfile`: Added container labels, improved welcome banner, and clarified goose install steps. Now recommends using `uv` for Python package management. General cleanup and documentation improvements.
- `.devcontainer/devcontainer.json`: Added `postStartCommand` to run `poststart.sh` after container start. Cleaned up comments.

### Removed
- `notes.md`: Removed as content was migrated or completed.
- `WIP_get_creds.sh`: Removed obsolete credentials helper script.

## [0.1.0] - 2026-01-11
### Added
- `WIP_get_creds.sh`: Toy script working towards copying existing goose credentials into the devcontainer for seamless authentication.

### Changed
- `.devcontainer/Dockerfile`: R (latest) and Julia (latest via `juliaup`) now included in the devcontainer for multi-language support.
- `.devcontainer/devcontainer.json`: Julia extension for VS Code/Positron added to the recommended list.
- `README.md`: Updated to reflect the addition of R and Julia in the devcontainer setup.
- `notes.md`: Removed notes on completed TODOs.

### Removed
- `upgrades.md`: Planned upgrades completed.

## [0.0.1] - 2025-12-16
### Added
- `.devcontainer/Dockerfile`: Python devcontainer with Goose CLI, common dev tools, and Python packages.
- `.devcontainer/devcontainer.json`: VS Code/Positron devcontainer config with Python, Goose, and recommended extensions.
- `.github/AGENTS.md`: Global agent rules and standards for code, naming, and collaboration.
- `notes.md`: Implementation notes, platform caveats, and TODOs for devcontainer and agent setup.

### Changed
- Expanded `README.md` to document new devcontainer and agent configuration files, usage, and standards.