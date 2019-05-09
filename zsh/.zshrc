#-------------------------------------------------------------------------------
# Preload
#-------------------------------------------------------------------------------

# Macports
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

#-------------------------------------------------------------------------------
# ZPlug
#-------------------------------------------------------------------------------

# Source in the package manager
source ~/.zplug/init.zsh

# Self manage
zplug 'zplug/zplug', hook-build: 'zplug --self-manage'

# Load Oh-My-Zsh Libraries but only the ones we want
zplug "lib/completion",   from:oh-my-zsh
zplug "lib/correction",   from:oh-my-zsh
zplug "lib/git",   from:oh-my-zsh
zplug "lib/grep",   from:oh-my-zsh
zplug "lib/history",   from:oh-my-zsh
zplug "lib/key-bindings",   from:oh-my-zsh
zplug "lib/spectrum",   from:oh-my-zsh
zplug "lib/termsupport",   from:oh-my-zsh
zplug "lib/theme-and-appearance",   from:oh-my-zsh

# General
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/pass",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/vi-mode",   from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "~/.zsh/plugins/git-prompt", from:local

# Dev Plugins
zplug "plugins/cargo",   from:oh-my-zsh
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/python",   from:oh-my-zsh
zplug "plugins/virtualenv",   from:oh-my-zsh

# Commands
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:"fzf"

# OS X
if [[ $OSTYPE =~ "darwin*" ]]; then
  zplug "plugins/macports",   from:oh-my-zsh
  zplug "plugins/osx",   from:oh-my-zsh
fi

# Load local themes
zplug '~/.zsh/themes', from:local, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Apply changes
zplug load

#-------------------------------------------------------------------------------
# General ZSH Settings
#-------------------------------------------------------------------------------

# Set theme
ZSH_THEME="jellybeans"

# Allow _ and - interchangeability
HYPHEN_INSENSITIVE="true"

# Ignore duplicates in history
HISTCONTROL=ignoredups

# Max highlighting
ZSH_HIGHLIGHT_MAXLENGTH=300

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Aliases
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# radare2
alias r2='radare2'

# ranger
alias r='ranger'

# tmux
alias t='tmux -2'
alias ta='tmux -2 attach'

# vmrun
if [[ $OSTYPE =~ "darwin*" ]]; then
  if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
    alias vmrun="/Applications/VMware\ Fusion.app/Contents/Library/vmrun"
  fi
fi

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Bindings
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Vi mode
bindkey -v

# zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# Set beginning search as default
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '^p' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

# Reset, gets overridden
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

# Bind the delete key, we dont want cap oddness
bindkey "\e[3~" delete-char

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Sources
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Source in fzf
source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exports
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Pass - password-store
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PINENTRY_USER_DATA="USE_CURSES=1"

# No I don't want a visible go folder...
export GOPATH="${HOME}/.go"
export PATH="${PATH}:${GOPATH}/bin"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable thefuck
if [ `command -v 'thefuck'` ]; then
  eval "$(thefuck --alias)"
fi

# Setup FZF
_gen_fzf_default_opts() {
  local color00='#1d1f21'
  local color01='#282a2e'
  local color02='#373b41'
  local color03='#969896'
  local color04='#b4b7b4'
  local color05='#c5c8c6'
  local color06='#e0e0e0'
  local color07='#ffffff'
  local color08='#cc6666'
  local color09='#de935f'
  local color0A='#f0c674'
  local color0B='#b5bd68'
  local color0C='#8abeb7'
  local color0D='#81a2be'
  local color0E='#b294bb'
  local color0F='#a3685a'

  export FZF_DEFAULT_OPTS="
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  "
}
_gen_fzf_default_opts
if whence -cp 'ag' > /dev/null; then
  export FZF_DEFAULT_COMMAND='ag -l --hidden --follow --ignore .git'
fi

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Fixes
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# FIXME Needed to fix: https://github.com/zplug/zplug/issues/383
# Required removal of https://github.com/zplug/zplug/pull/355/files#diff-fb361a0797fa562c6352fa10675bfbaaR6
setopt monitor

# FIXME Needed to fix: https://github.com/zplug/zplug/issues/387
export PATH="${PATH}:${ZPLUG_BIN}"
