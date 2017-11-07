# dotfiles

## Setup

This repository makes use of stow to manage the dot files.

### Linux

```bash
sudo apt-get install stow
git clone https://github.com/AlexKornitzer/dotfiles.git ~/Dotfiles
cd ~/Dotfiles
git submodule init
git submodule update
```

### MacOS

```bash
brew install stow
git clone https://github.com/AlexKornitzer/dotfiles.git ~/Dotfiles
cd ~/Dotfiles
git submodule init
git submodule update
```

## Stows

### bash

Nothing special to do for this one.

```bash
stow bash
```

### i3

This one has a fair few dependencies, most are listed below.

> Dependencies:
> - DejaVu Sans Mono
> - Dunst
> - Faba Mono
> - Font Awesome
> - i3blocks
> - i3ipc (Python)
> - Numix-Jellybeans (https://github.com/AlexKornitzer/numix-jellybeans-gtk-theme)
> - Rofi

```bash
stow i3
```

### tmux

Nothing special to do for this one.

```bash
stow tmux
```

### vim

Nothing special to do here as `vim` does all of the work.

> Dependencies:
> - cmake
> - gcc
> - cscope
> - ctags

```bash
stow vim
vim -c PlugInstall
```

### xfce

Nothing special to do for this one.

> Dependencies:
> - DejaVu Sans Mono
> - Numix-Jellybeans (https://github.com/AlexKornitzer/numix-jellybeans-gtk-theme)

```bash
stow xfce
```

### zsh

Nothing special to do for this one.

```bash
stow zsh
```
