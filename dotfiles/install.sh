#!/usr/bin/env bash

set -euo pipefail

# resolve dir
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOADER_FILE="$REPO_DIR/bash/loader.sh"
BASHRC="$HOME/.bashrc"
MARKER="# >>> dotfiles-loader >>>"

if [ ! -f "$LOADER_FILE" ]; then
	echo "Error: Could not find $LOADER_FILE" >&2
	exit 1
fi

# make sure ~/.bashrc exists
touch "$BASHRC"

# append loader if not present
if grep -FFq "$MARKER" "$BASHRC"; then
	echo "Dotfiles loader already configured in $BASHRC"
else
	# back up
	cp "$BASHRC" "${BASHRC}.bak.$(date +%Y%m%d%H%M%S)"
	cat <<EOF >> "$BASHRC"

$MARKER
[ -r "$LOADER_FILE" ] && source "$LOADER_FILE"
# <<< dotfiles-loader <<<
EOF

	echo "Backed up $BASHRC and added dotfiles loader."
fi

echo "Done! Run 'source ~/.bashrc' to apply your config."
