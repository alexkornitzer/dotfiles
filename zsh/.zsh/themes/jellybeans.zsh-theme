# vim:ft=zsh ts=2 sw=2 sts=2

# Globals
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} …"

# Locals
local user='%{$fg[green]%}%n@%{$fg[green]%}%m%{$reset_color%}'
local pwd='%{$fg[blue]%}%~%{$reset_color%}'
local return_status="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local git_branch=' $(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}'

# Functions
MODE_INDICATOR="%{$fg_bold[blue]%} [% NORMAL]% %{$reset_color%}"
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# Prompt
PROMPT="${user} ${pwd}$ "
RPROMPT="${return_status}"'$(vi_mode_prompt_info)'"${git_branch}"
