# Custom color codes
typeset -A color
color=(
  "yellow" "#2B282F"
  "red" "#375949"
  "green" "#808D71"
  "blue" "#B8B6C3"
  "cyan" "#AAEB83"
  "magenta" "#375949"
)

# RVM settings
if [[ -s ~/.rvm/scripts/rvm ]]; then
  RPS1="%{$fg[yellow]%}rvm:%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
else
  if which rbenv &> /dev/null; then
    RPS1="%{$fg[yellow]%}rbenv:%{$reset_color%}%{$fg[red]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$reset_color%} $EPS1"
  fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Functions to get the current git branch and its status
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Function to retrieve the current virtual environment's name
venv_prompt() {
  if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    # For conda environments
    echo "%{$fg[blue]%}($CONDA_DEFAULT_ENV)%{$reset_color%}"
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    # For virtualenv/venv environments
    echo "%{$fg[blue]%}(${VIRTUAL_ENV:t})%{$reset_color%}"
  else
    echo ""
  fi
}

# Returns the amount of spaces needed to align the RPROMPT to the far right.
get_space () {
  local zero='%([BSUbfksu]|([FB]|){*})'

  local LEFT_LENGTH=${#${(S%%)LEFT_CONTENT//$~zero/}}
  local RIGHT_LENGTH=${#${(S%%)RIGHT_CONTENT//$~zero/}}

  local TOTAL_LENGTH=$(( LEFT_LENGTH + RIGHT_LENGTH ))
  local SPACES=$(( COLUMNS - TOTAL_LENGTH - ${ZLE_RPROMPT_INDENT:-1} ))

  (( SPACES > 0 )) || return
  printf ' %.0s' {1..$SPACES}
}

# Using PROMPT_SUBST option
setopt prompt_subst

precmd() {
  # Update global variables each time before the prompt is displayed
  LEFT_CONTENT="$(venv_prompt)$(git_custom_status)%{$fg[cyan]%}[%2~% ]%{$reset_color%}"
  RIGHT_CONTENT="%{$fg[magenta]%}%n@%m%{$reset_color%}" 
}

# Dynamic prompt construction with username in magenta
PROMPT='${LEFT_CONTENT}$(get_space)${RIGHT_CONTENT}
%b$%b '

