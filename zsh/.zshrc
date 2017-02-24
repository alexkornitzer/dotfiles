#-------------------------------------------------------------------------------
# ZPlug
#-------------------------------------------------------------------------------

# Source in the package manager
source ~/.zplug/init.zsh

# General
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/vi-mode",   from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "~/.zsh/plugins/git-prompt", from:local

# Python Plugins
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/python",   from:oh-my-zsh
zplug "plugins/virtualenv",   from:oh-my-zsh

# OS X
if [ "$OSTYPE" = "darwin11.0" ]; then
  zplug "plugins/brew",   from:oh-my-zsh
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

# Enable tab highlighting
zstyle ':completion:*' menu select

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
elif [[ "`uname`" == 'Darwin' ]]; then
  export LSCOLORS=exfxcxdxcxExDxabagacad
  alias ls='ls -G'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable thefuck
if [ `command -v 'thefuck'` ]; then
  eval "$(thefuck --alias)"
fi

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Aliases
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ls
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lF'

# radare2
alias r2='radare2'

# tmux
alias t='tmux -2'
alias ta='tmux -2 attach'

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
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search
