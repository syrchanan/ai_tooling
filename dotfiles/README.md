# dotfiles

Shell config, snippets and shorthands I rely on in WSL/linux, plus global AI agent instructions (`ai/`).

## usage

run install.sh to set things up; with no flags it installs everything

```bash
./install.sh            # everything
./install.sh --bash     # append loader.sh to ~/.bashrc
./install.sh --ai       # AI tooling: symlink ai/CLAUDE.md to ~/.claude/CLAUDE.md
./install.sh -h         # help
```

both steps are idempotent and back up anything they would replace
