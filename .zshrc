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

# Load starship
eval "$(starship init zsh)"
