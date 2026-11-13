#!/usr/bin/env bash

set -euo pipefail

# resolve dir
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
	cat <<EOF
Usage: install.sh [--bash] [--ai] [--all] [-h]
  --bash    add loader to ~/.bashrc
  --ai      set up AI tooling (links ai/CLAUDE.md to ~/.claude/CLAUDE.md)
  --all     everything (default when no flags given)
EOF
}

DO_BASH=0
DO_AI=0
for arg in "$@"; do
	case "$arg" in
		--bash)    DO_BASH=1 ;;
		--ai)      DO_AI=1 ;;
		--all)     DO_BASH=1; DO_AI=1 ;;
		-h|--help) usage; exit 0 ;;
		*) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
	esac
done

# no flags -> all
if [ $((DO_BASH + DO_AI)) -eq 0 ]; then
	DO_BASH=1
	DO_AI=1
fi

install_bash() {
	local loader_file="$REPO_DIR/bash/loader.sh"
	local bashrc="$HOME/.bashrc"
	local marker="# >>> dotfiles-loader >>>"

	if [ ! -f "$loader_file" ]; then
		echo "Error: Could not find $loader_file" >&2
		exit 1
	fi

	# make sure ~/.bashrc exists
	touch "$bashrc"

	# append loader if not present
	if grep -Fq "$marker" "$bashrc"; then
		echo "Dotfiles loader already configured in $bashrc"
	else
		# back up
		cp "$bashrc" "${bashrc}.bak.$(date +%Y%m%d%H%M%S)"
		cat <<EOF >> "$bashrc"

$marker
[ -r "$loader_file" ] && source "$loader_file"
# <<< dotfiles-loader <<<
EOF

		echo "Backed up $bashrc and added dotfiles loader."
	fi
}

install_claude() {
	local src="$REPO_DIR/ai/CLAUDE.md"
	local dst="$HOME/.claude/CLAUDE.md"

	if [ ! -f "$src" ]; then
		echo "Error: Could not find $src" >&2
		exit 1
	fi

	mkdir -p "$HOME/.claude"

	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		echo "CLAUDE.md already linked at $dst"
	else
		# back up an existing file rather than clobbering it
		if [ -e "$dst" ] || [ -L "$dst" ]; then
			mv "$dst" "${dst}.bak.$(date +%Y%m%d%H%M%S)"
			echo "Backed up existing $dst"
		fi
		ln -s "$src" "$dst"
		echo "Linked $dst -> $src"
	fi
}

install_ai() {
	install_claude
}

if [ "$DO_BASH" -eq 1 ]; then
	install_bash
fi
if [ "$DO_AI" -eq 1 ]; then
	install_ai
fi

echo "Done!"
if [ "$DO_BASH" -eq 1 ]; then
	echo "Run 'source ~/.bashrc' to apply your config."
fi
