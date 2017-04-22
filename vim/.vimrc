"-------------------------------------------------------------------------------
" Vim-Plug Plugin Manager
"-------------------------------------------------------------------------------

" Make sure Vim-Plug is installed
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim'
    \ 'https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Start
call plug#begin('~/.vim/plugged')

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Completion
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Jedi: Using the jedi autocompletion library for Vim
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Snippets: vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets'

" UltiSnips: The ultimate snippet solution for Vim. Send pull requests to
" SirVer/ultisnips!
Plug 'SirVer/ultisnips'

" YouCompleteMe: A code-completion engine for Vim
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Integrations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Easytags: Automated tag file generation and syntax highlighting of tags in
" Vim
Plug 'xolox/vim-easytags'

" Fugitive: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Tmuxline: Simple tmux statusline generator with support for powerline
" symbols and statusline / airline / lightline integration
" Plug 'edkolev/tmuxline.vim' Needs to fix the error
Plug 'maman/tmuxline.vim'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Interface
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Airline: lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" CommandT: Fast file navigation for Vim
function! BuildCommandT(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !cd ruby/command-t && ruby extconf.rb && make
  endif
endfunction
Plug 'wincent/command-t', { 'do': function('BuildCommandT') }

" CtrlP: Fuzzy file, buffer, mru, tag, etc finder
" TODO: Will probably remove in favour of command-t
Plug 'ctrlpvim/ctrlp.vim'

" IndentLine: A vim plugin to display the indention levels with thin vertical
" lines
Plug 'Yggdroot/indentLine'

" Nerdtree: A tree explorer plugin for Vim
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeTabsToggle' ] }

" NertTreeTabs: NERDTree and tabs together in Vim, painlessly
Plug 'jistr/vim-nerdtree-tabs', { 'on': [ 'NERDTreeToggle', 'NERDTreeTabsToggle' ] }

" Rainbow: help you read complex code by showing diff level of parentheses in
" diff color !!
Plug 'luochen1990/rainbow'

" Signify: Show a diff using Vim sign column
Plug 'mhinz/vim-signify'

" Tagbar: Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Cocoa: Vim plugin for Cocoa/Objective-C development
Plug 'AlexKornitzer/cocoa.vim', { 'for': ['objc', 'objc++'] }

" Javascript: Vastly improved Javascript indentation and syntax support in
" Vim.
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" LaTeXBox: Lightweight Toolbox for LaTeX
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }

" PS1: A Vim plugin for Windows PowerShell support
Plug 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }

" Syntastic: Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" TexSyntax: Vim TeX syntax file
if v:version >= 800
  Plug 'gi1242/vim-tex-syntax'
endif

" Typescript: Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Miscellaneous
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Cscope: A vim plugin to help you to create/update cscope database and connect
"to existing proper database automatically.
Plug 'brookhong/cscope.vim'

" FastFold: Speed up Vim by updating folds only when called-for
Plug 'Konfekt/FastFold'

" Stay: Make Vim persist editing state without fuss
Plug 'kopischke/vim-stay'

" Misc: Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Themes
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Jellybeans: A colorful, dark color scheme for Vim
Plug 'nanotech/jellybeans.vim'

" End
call plug#end()

"-------------------------------------------------------------------------------
" Genreal Vim Settings
"-------------------------------------------------------------------------------

" Set terminal to 256 colours
set t_Co=256

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

" Enable true colour support if the terminal supports it
if $COLORTERM=~"truecolor"
  set termguicolors
endif

" Turn syntax highlighting on
syntax on

" Turn on file type recognition
filetype on

" Turn on line numnbers
set number

" Set the background to dark and set the colour scheme
set background=dark
colorscheme jellybeans

" Map back space
set backspace=indent,eol,start

" Set up indent and tab settings
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set scroll settings
set scrolloff=10

" Turn on Omni completion
set omnifunc=syntaxcomplete#Complete

"-------------------------------------------------------------------------------
" Plugin Settings
"-------------------------------------------------------------------------------

"*******************************************************************************
" System Plugin Settings
"*******************************************************************************

" Configure settings for the Tex.vim plugin
let g:tex_comment_nospell= 1
let g:tex_flavor = 'latex'
let g:tex_fold_enabled=1

"*******************************************************************************
" Local Plugin Settings
"*******************************************************************************

" Load pluging settings from the settings folder
source $HOME/.vim/settings/Airline.vim              " Plugin: Airline
source $HOME/.vim/settings/EasyTags.vim             " Plugin: EasyTags
source $HOME/.vim/settings/FastFold.vim             " Plugin: FastFold
source $HOME/.vim/settings/IndentLine.vim           " Plugin: IndentLine
source $HOME/.vim/settings/Jedi.vim                 " Plugin: Jedi
source $HOME/.vim/settings/LaTeX-Box.vim            " Plugin: LaTeX-Box
source $HOME/.vim/settings/NERDTree.vim             " Plugin: NERDTree
source $HOME/.vim/settings/Syntastic.vim            " Plugin: Syntastic
source $HOME/.vim/settings/Tagbar.vim               " Plugin: Tagbar
source $HOME/.vim/settings/TagList.vim              " Plugin: TagList
source $HOME/.vim/settings/UltiSnips.vim            " Plugin: UltiSnips
source $HOME/.vim/settings/Vim-Stay.vim             " Plugin: Vim-Stay
source $HOME/.vim/settings/Vim-Tex-Syntax.vim       " Plugin: Vim-Tex-Syntax
source $HOME/.vim/settings/YouCompleteMe.vim        " Plugin: YouCompleteMe

"-------------------------------------------------------------------------------
" Fixes for TODOS
"-------------------------------------------------------------------------------

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"-------------------------------------------------------------------------------
" Functions
"-------------------------------------------------------------------------------

" Function to trim white space
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" Helps with syntax debugging
if has("user_commands")
    command -nargs=0 -bar WhatSyntax echomsg synIDattr(synID(line("."),col("."),0),"name") synIDattr(synIDtrans(synID(line("."),col("."),0)),"name") synIDattr(synID(line("."),col("."),1),"name") synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
endif

"-------------------------------------------------------------------------------
" Auto Commands
"-------------------------------------------------------------------------------

" auto command to close NERDTree and Tag List if they are the only windows open. https://yous.be/2014/11/30/automatically-quit-vim-if-actual-files-are-closed
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

" Auto commands to save and load views
" TODO: No Longer needed as we have Vim-Stay
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" Auto commands to trim white space on pre buffer write
autocmd BufWritePre * :call TrimWhiteSpace()

" Fix for nasm syntax not being set on *.nasm file type
autocmd BufRead,BufNewFile,Bufenter *.nasm set filetype=nasm

"-------------------------------------------------------------------------------
" Auto Commands
"-------------------------------------------------------------------------------

" Map NERDTree to tt
nmap tt :NERDTreeToggle<CR>

" Map NERDTreeTabs to ta
nmap ta :NERDTreeTabsToggle<CR>

" Map Tagbar to tb
nmap tb :TagbarToggle<CR>

" Map spelling to ts
function! SpellToggle()
  if &spell
    setlocal nospell
    setlocal spellfile=
  else
    let &l:spellfile=expand('%:p:h').'/.vimspell.utf-8.add'
    setlocal spell
    setlocal spelllang=en_gb
  endif
  echo "Spell Checking - On:" &spell "Lang:" &spelllang  "Local:" &l:spellfile
endfunction
nmap ts :call SpellToggle()<CR>
