#!/bin/bash

# Repository location 
REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Config file locations
ZSHRC_DEST="$HOME/.zshrc"
TMUX_DEST="$HOME/.config/tmux/tmux.conf"
STARSHIP_DEST="$HOME/.config/starship.toml"

# Ensure necessary directories exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/tmux"

new_symlink() {
  local src="$REPO_DIR/$1"
  local dest=$2

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Deleting old symlink or file: $dest"
    rm -rf "$dest"
  fi 

  echo "Creating new symlink: $src -> $dest"
  ln -s "$src" "$dest"
}

# Ask for confirmation before executing
echo "This script will remove existing files and create new symlinks for the config files."
read -p "Do you want to continue? (y/N): " proceed
if [[ "proceed" != "y" && "proceed" != "Y" ]]; then
  echo "Symlink creation aborted!"
  exit 0
fi

# Create symlinks
new_symlink ".zshrc" "$ZSHRC_DEST"
new_symlink "tmux.conf" "$TMUX_DEST"
new_symlink "starship.toml" "$STARSHIP_DEST"

echo "New symlinks have been created!"
