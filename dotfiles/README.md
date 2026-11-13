# utils

This folder contains a bunch of snippets and shorthands that I rely on in general in WSL/linux

## usage

run install.sh to set things up; with no flags it installs everything

```bash
./install.sh            # everything
./install.sh --bash     # append loader.sh to ~/.bashrc
./install.sh --ai       # AI tooling: symlink ai/CLAUDE.md to ~/.claude/CLAUDE.md
./install.sh -h         # help
```

both steps are idempotent and back up anything they would replace
