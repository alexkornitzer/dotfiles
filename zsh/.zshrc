#-------------------------------------------------------------------------------
# Preload
#-------------------------------------------------------------------------------

export LANG=en_GB.UTF-8

# Load in completions
if [[ $OSTYPE =~ "darwin*" ]]; then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

#-------------------------------------------------------------------------------
# Antidote
#-------------------------------------------------------------------------------

# Helpers

is-macos() {
  [[ $OSTYPE == darwin* ]]
}

run_fzf_postinstaller() {
  if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]]; then
    $(antidote path junegunn/fzf)/install --xdg --no-bash --no-fish --all
  else
    $(antidote path junegunn/fzf)/install --bin
  fi
}

# Source in the package manager
ANTIDOTE_HOME="${ZDOTDIR:-$HOME}/.antidote"
[[ -r "${ANTIDOTE_HOME}/antidote.zsh" ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ANTIDOTE_HOME}
source "${ANTIDOTE_HOME}/antidote.zsh"

# Load plugins from ~/.zsh_plugins.txt
antidote load

source "${HOME}/.zsh/plugins/git-prompt/git-prompt.plugin.zsh"
source "${HOME}/.zsh/themes/jellybeans.zsh-theme"

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

# Source in direnv
if [ `command -v 'direnv'` ]; then
  eval "$(direnv hook zsh)"
fi

# Source in jj completions
if [ `command -v 'jj'` ]; then
  source <(jj util completion zsh)
fi

# Source in nvm
if [ -f /opt/local/share/nvm/init-nvm.sh ]; then
  source /opt/local/share/nvm/init-nvm.sh
fi

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Exports
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Neovim
if [ `command -v 'nvim'` ]; then
  export EDITOR="nvim"
fi

# Use 1Password SSH authentication socket
if [ -e "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable thefuck
if [ `command -v 'thefuck'` ]; then
  eval "$(thefuck --alias)"
fi

# Setup FZF
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS='--color=bg+:#3a363a,bg:#262427,spinner:#49cae4,hl:#49cae4,fg:#fcfcfa,header:#1c1b1c,info:#5f5f5f,pointer:#49cae4,marker:#49cae4,fg+:#fcfcfa,prompt:#49cae4,hl+:#49cae4'
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

export YAMLFIX_SECTION_WHITELINES=1
