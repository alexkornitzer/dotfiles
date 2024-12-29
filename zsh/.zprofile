# MacPorts Installer addition on 2023-05-27_at_17:58:44: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Local binaries
export PATH="${PATH}:${HOME}/.local/bin"

# Add Ghostty
export PATH="${PATH}:/Applications/Ghostty.app/Contents/MacOS"

# Add python
if [ `command -v 'python3'` ]; then
  export PATH="${PATH}:`python3 -m site --user-base`/bin"
fi

# No I don't want a visible go folder...
export GOPATH="${HOME}/.go"
export PATH="${PATH}:${GOPATH}/bin"

export TFENV_CONFIG_DIR="${HOME}/.tfenv"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
