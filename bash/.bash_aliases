#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

# ls
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lF'

# radare2
alias r2='radare2'

# tmux
alias t='tmux -2'
alias ta='tmux -2 attach'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
