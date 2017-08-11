# vim:ft=zsh ts=2 sw=2 sts=2

# Notes:
# This theme relies on the following oh-my-zsh plugins:
# 1. vi-mode
# 2. git-prompt

# Globals
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}git:["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[white]%}virtualenv:[%{$fg[green]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg[white]%}]"

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
function virtualenv_prompt_info_wrap() {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo " %{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}"
}

# Prompt
PROMPT="${user} ${pwd}$ "
RPROMPT="${return_status}"'$(vi_mode_prompt_info)$(virtualenv_prompt_info_wrap)$(git_super_status)'
