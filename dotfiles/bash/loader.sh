# resolve dir
_DOTFILES_SOURCE="${BASH_SOURCE[0]}"
while [ -L "$_DOTFILES_SOURCE" ]; do
	_DOTFILES_DIR="$(cd -P "$(dirname "$_DOTFILES_SOURCE")" && pwd)"
	_DOTFILES_SOURCE="$(readlink "$_DOTFILES_SOURCE")"
	[[ $_DOTFILES_SOURCE != /* ]] && _DOTFILES_SOURCE="$_DOTFILES_DIR/$_DOTFILES_SOURCE"
done
_LOADER_DIR="$(cd -P "$(dirname "$_DOTFILES_SOURCE")" && pwd)"
_LIBS_DIR="$_LOADER_DIR/libs"

# source all sh
if [ -d "$_LIBS_DIR" ]; then
	for _file in "$_LIBS_DIR"/*.sh; do
		[ -r "$_file" ] && source "$_file"
	done
	unset _file
fi

# load local mod
[ -r "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"

unset _DOTFILES_SOURCE _DOTFILES_DIR _LOADER_DIR _LIBS_DIR