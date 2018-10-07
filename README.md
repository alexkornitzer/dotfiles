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

### i3

This one has a fair few dependencies, most are listed below.

> Dependencies:
> - [Adapta-Nokto](https://github.com/adapta-project/adapta-gtk-theme) (Tag: 3.95.0.1) (`./autogen.sh --prefix=/usr --enable-parallel --with-selection_color=#597bc5 --with-accent_color=#597bc5 --with-suggestion_color=#597bc5 --with-destruction_color=#cf6a4c`)
> - Dunst
> - Faba Mono
> - Font Awesome
> - Noto Sans
> - i3blocks
> - i3ipc (Python)
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
vim +PlugInstall +qall
```

### xfce

Nothing special to do for this one.

> Dependencies:
> - Noto Sans
> - Numix-Jellybeans (https://github.com/AlexKornitzer/numix-jellybeans-gtk-theme)

```bash
stow xfce
```

### zsh

Nothing special to do for this one.

```bash
stow zsh
```
