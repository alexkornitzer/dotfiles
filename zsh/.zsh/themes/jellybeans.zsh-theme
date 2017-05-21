# vim:ft=zsh ts=2 sw=2 sts=2

# Notes:
# This theme relies on the following oh-my-zsh plugins:
# 1. vi-mode
# 2. git-prompt

# Globals
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[yellow]%}"

# Locals
local user='%{$fg[green]%}%n@%{$fg[green]%}%m%{$reset_color%}'
local pwd='%{$fg[blue]%}%~%{$reset_color%}'
local return_status=" %(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local git_branch=' $(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}'

# Functions
MODE_INDICATOR="%{$fg_bold[blue]%} [% NORMAL]% %{$reset_color%}"
function vi_mode_prompt_info() {
  echo " ${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# Prompt
PROMPT="${user} ${pwd}$ "
RPROMPT="${return_status}"'$(vi_mode_prompt_info) %{$fg[magenta]%}$(virtualenv_prompt_info)%{$reset_color%} $(git_super_status)'
