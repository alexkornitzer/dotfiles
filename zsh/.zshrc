#-------------------------------------------------------------------------------
# Antigen
#-------------------------------------------------------------------------------

# Source in the package manager
# ZSHA_BASE=$HOME/.zsh-antigen
# source $ZSHA_BASE/antigen/antigen.zsh
source $HOME/.antigen/antigen.zsh

# Set Oh-My-Zsh as default
antigen use oh-my-zsh

# Load in raw Oh-My-Zsh cause we need it!?!?!
antigen bundle robbyrussell/oh-my-zsh ~/.oh-my-zsh

# General
antigen bundle command-not-found
antigen bundle git
antigen bundle git-prompt
antigen bundle pip
antigen bundle tmux
antigen bundle vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting

# OS X
if [ "$OSTYPE"="darwin11.0" ]; then
  antigen bundle brew
  antigen bundle osx
fi

# Apply changes
antigen apply

#-------------------------------------------------------------------------------
# General ZSH Settings
#-------------------------------------------------------------------------------

# Set the theme
source $HOME/.zsh/themes/jellybeans.zsh-theme
ZSH_THEME="jellybeans"

# Allow _ and - interchangeability
HYPHEN_INSENSITIVE="true"

# Ignore duplicates in history
HISTCONTROL=ignoredups

# Enable thefuck
eval $(thefuck --alias)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Bindings
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Vi mode
bindkey -v

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
