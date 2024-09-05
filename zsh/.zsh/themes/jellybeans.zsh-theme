# vim:ft=zsh ts=2 sw=2 sts=2

# Notes:
# This theme relies on the following oh-my-zsh plugins:
# 1. terraform
# 2. virtualenv

# Globals
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}git:["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]"
ZSH_THEME_GIT_PROMPT_BRANCH="%F{#9399B2}"

ZSH_THEME_TF_PROMPT_PREFIX="%{$fg[white]%}terraform:[%F{#9399B2}"
ZSH_THEME_TF_PROMPT_SUFFIX="%{$fg[white]%}]"
ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[white]%}virtualenv:[%F{#9399B2}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg[white]%}]"

# Locals
local user='%F{#F2CDCD}%n%F{#F2CDCD}@%m%{$reset_color%}'
local pwd='%{$fg[blue]%}%~%{$reset_color%}'
local return_status=" %(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local git_branch=' $(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}'
local exec_time='%{$fg[yellow]%}${human_exec_time}%{$reset_color%}'

# Functions
function virtualenv_prompt_info_wrap() {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo " %{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}"
}
function check_cmd_exec_time() {
	integer elapsed
	(( elapsed = EPOCHSECONDS - ${cmd_timestamp:-$EPOCHSECONDS} ))
	(( elapsed > 0 )) && {
	  local human total_seconds=$elapsed
	  local days=$(( total_seconds / 60 / 60 / 24 ))
	  local hours=$(( total_seconds / 60 / 60 % 24 ))
	  local minutes=$(( total_seconds / 60 % 60 ))
	  local seconds=$(( total_seconds % 60 ))
	  (( days > 0 )) && human+="${days}d "
	  (( hours > 0 )) && human+="${hours}h "
	  (( minutes > 0 )) && human+="${minutes}m "
	  human+=" ${seconds}s"
	  typeset -g human_exec_time=${human}
	}
}
# From https://www.reddit.com/r/zsh/comments/cgbm24/multiline_prompt_the_missing_ingredient/
function prompt-length() {
 emulate -L zsh
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
 echo $x
}
function preexec() {
	unset human_exec_time
  typeset -g cmd_timestamp=$EPOCHSECONDS
}
function precmd() {
  check_cmd_exec_time
	unset cmd_timestamp
}

zmodload -F zsh/datetime p:EPOCHSECONDS
autoload -U add-zsh-hook
add-zsh-hook precmd precmd
add-zsh-hook preexec preexec

# Prompt
function build_rprompt() {
  local lprompt="${user} ${pwd}"
  local rprompt="$(virtualenv_prompt_info_wrap)$(tf_prompt_info)$(git_super_status)"
  local left_len=$(prompt-length $lprompt)
  local right_len=$(prompt-length $rprompt)
  local fill=$((COLUMNS - left_len - right_len))
  echo ${(l:$fill:)}${rprompt}${hack}
}
PROMPT="${user} ${pwd}"'$(build_rprompt)'$'\n'"%{$fg[magenta]%}❯%{$reset_color%} "
RPROMPT="${return_status}${exec_time}"
