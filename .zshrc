# oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME=""

# Plugins
plugins=(git zsh-autosuggestions virtualenv)

source $ZSH/oh-my-zsh.sh

# Aliases

alias vim="nvim"

alias zshconf="nvim ~/.zshrc"

alias zshload="source ~/.zshrc"

alias starconf="nvim ~/.config/starship.toml"

export PATH=~/bin:$PATH

# Set default editor
export EDITOR=nvim

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# uv
. "$HOME/.local/bin/env"

# Load starship
eval "$(starship init zsh)"

