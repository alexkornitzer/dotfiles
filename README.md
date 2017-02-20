# dotfiles

## Setup

This repository makes use of stow to manage the dot files.

### Linux

```bash
sudo apt-get install stow
```

### MacOS

```bash
brew install stow
```

## Stows

### bash

Nothing special to do for this one.

```bash
stow bash
```

### i3

This one has a fair few dependencies that are crudely listed in a shell script.

```bash
stow i3
cd ~/.i3
./setup.sh
```

### tmux

Nothing special to do for this one.

```bash
stow tmux
```

### vim

Nothing special to do here as `vim` does all of the work.

```bash
stow vim
vim -c PlugInstall
```

### zsh

Nothing special to do for this one.

```bash
stow zsh
```
