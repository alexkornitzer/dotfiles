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
# Zinit
#-------------------------------------------------------------------------------

# Source in the package manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zdharma-continuum/zinit-annex-patch-dl

# Load Oh-My-Zsh Libraries but only the ones we want
zi snippet OMZL::completion.zsh
zi snippet OMZL::correction.zsh
zi snippet OMZL::git.zsh
zi snippet OMZL::grep.zsh
zi snippet OMZL::history.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::spectrum.zsh
zi snippet OMZL::termsupport.zsh
zi snippet OMZL::theme-and-appearance.zsh

## General
zi snippet OMZP::command-not-found

zi snippet OMZP::git

zi ice as"completition"
zi snippet OMZP::pass/_pass

zi snippet OMZP::tmux

zi light zsh-users/zsh-autosuggestions

zi light catppuccin/zsh-syntax-highlighting

zi light zsh-users/zsh-syntax-highlighting

zi ice from"local"
zi light ~/.zsh/plugins/git-prompt

# Dev Plugins
zi snippet OMZP::pip

zi snippet OMZP::python

zi ice git
zi snippet OMZP::rust

zi snippet OMZP::virtualenv

# Commands
zinit ice as"command" from"gh-r" src'key-bindings.zsh' completions \
      dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh;
         https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/share/man/man1/fzf.1;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/share/man/man1/fzf-tmux.1;'
zinit light junegunn/fzf

# OS X
if [[ $OSTYPE =~ "darwin*" ]]; then
  zi snippet OMZP::macports

  zi ice svn
  zi snippet OMZP::macos
fi

# Load local themes
setopt promptsubst
zi ice from"local" as"theme"
zi light ~/.zsh/themes

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
