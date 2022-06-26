#-------------------------------------------------------------------------------
# Preload
#-------------------------------------------------------------------------------

export LANG=en_GB.UTF-8

# Macports
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Python
if [[ $OSTYPE =~ "darwin*" ]]; then
  export PATH="$PATH:`python -m site --user-base`/bin"
else
  export PATH="$PATH:$HOME/.local/bin"
fi

# Load in completions
if [[ $OSTYPE =~ "darwin*" ]]; then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

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

## General
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/pass",   from:oh-my-zsh
zplug "plugins/podman",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
#zplug "plugins/vi-mode",   from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "catppuccin/zsh-syntax-highlighting"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "~/.zsh/plugins/git-prompt", from:local

# Dev Plugins
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/python",   from:oh-my-zsh
zplug "plugins/rust",   from:oh-my-zsh
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

# Source in nvm
if [ -f /opt/local/share/nvm/init-nvm.sh ]; then
  source /opt/local/share/nvm/init-nvm.sh
fi

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exports
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Pass - password-store
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PINENTRY_USER_DATA="USE_CURSES=1"

# Add cargo
#export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${HOME}/.cargo/bin:${PATH}"

# Add python
if [ `command -v 'python3'` ]; then
  export PATH="${PATH}:`python3 -m site --user-base`/bin"
fi

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
  local color00='#2E3440'
  local color01='#3B4252'
  local color02='#434C5E'
  local color03='#4C566A'
  local color04='#D8DEE9'
  local color05='#E5E9F0'
  local color06='#ECEFF4'
  local color07='#8FBCBB'
  local color08='#88C0D0'
  local color09='#81A1C1'
  local color0A='#5E81AC'
  local color0B='#BF616A'
  local color0C='#D08770'
  local color0D='#EBCB8B'
  local color0E='#A3BE8C'
  local color0F='#B48EAD'

  export FZF_DEFAULT_OPTS="
    --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD
    --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 
    --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD
  "
}
_gen_fzf_default_opts
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
if whence -cp 'rg' > /dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!{.git/*}'"
fi
# Taken from: https://github.com/junegunn/fzf/issues/862
traverse-upwards() {
  local dir=$(
    [ $# = 1 ] && [ -d "$1" ] && cd "$1"
    while true; do
      find "$PWD" -mindepth 1 -maxdepth 1 -type d
      echo "$PWD"
      [ $PWD = / ] && break
      cd ..
    done | fzf --tiebreak=end --height 50% --reverse --preview 'tree -C {} | head -200'
  ) && cd "$dir"
}
zle -N traverse-upwards{,}
bindkey '^[j' traverse-upwards

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Fixes
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# FIXME Needed to fix: https://github.com/zplug/zplug/issues/383
# Required removal of https://github.com/zplug/zplug/pull/355/files#diff-fb361a0797fa562c6352fa10675bfbaaR6
setopt monitor

# FIXME Needed to fix: https://github.com/zplug/zplug/issues/387
export PATH="${PATH}:${ZPLUG_BIN}"
