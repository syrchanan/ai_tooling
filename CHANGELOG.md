# Changelog

All notable changes to this project will be documented in this file (via AI, minimally reviewed by a human).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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