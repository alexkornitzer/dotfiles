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
    "!./install.py --clang-completer
    let s:args = '--clang-completer'
    if executable('go')
      let s:args .= ' --go-completer'
    endif
    if executable('node') && executable('npm')
      let s:args .= ' --js-completer'
    endif
    if executable('rustc') && executable('cargo')
      if executable('rustup')
        execute '!rustup component add rust-src'
        execute '!rustup component add rustfmt-preview'
      endif
      let s:args .= ' --rust-completer'
    endif
    execute '!./install.py' s:args
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Integrations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Gutentags: A Vim plugin that manages your tag files
Plug 'ludovicchabant/vim-gutentags'

" Fugitive: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Tmuxline: Simple tmux statusline generator with support for powerline
" symbols and statusline / airline / lightline integration
" Plug 'edkolev/tmuxline.vim' Needs to fix the error
Plug 'kevinkjt2000/tmuxline.vim'

" Vimux: Vim plugin to interact with tmux
Plug 'benmills/vimux'

" VimuxCargo: Run cargo commands in vim
"Plug 'jtdowney/vimux-cargo'
Plug 'alexkornitzer/vimux-cargo'

" VimTmuxNavigator: Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Virtualenv:  Vim plugin for working with python virtualenvs
Plug 'jmcantrell/vim-virtualenv'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Interface
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Colorizer: color hex codes and color names 
Plug 'chrisbra/Colorizer', { 'for': ['css', 'html', 'sass', 'scss', 'vue'] }

" FZF: A command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" GitGutter: A Vim plugin which shows a git diff in the gutter (sign column)
" and stage/undoes hunks.
Plug 'airblade/vim-gitgutter'

" IndentLine: A vim plugin to display the indention levels with thin vertical
" lines
Plug 'Yggdroot/indentLine'

" LightLine: A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" LightLine ALE: ALE indicator for the lightline vim plugin
Plug 'maximbaz/lightline-ale'

" LightLine Bufferline: A lightweight plugin to display the list of buffers in the lightline vim plugin
Plug 'mgee/lightline-bufferline'

" Nerdtree: A tree explorer plugin for Vim
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeTabsToggle' ] }

" NertTreeTabs: NERDTree and tabs together in Vim, painlessly
Plug 'jistr/vim-nerdtree-tabs', { 'on': [ 'NERDTreeToggle', 'NERDTreeTabsToggle' ] }

" Rainbow: help you read complex code by showing diff level of parentheses in
" diff color !!
Plug 'luochen1990/rainbow'

" Tagbar: Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

" UndoTree: The ultimate undo history visualizer for Vim
Plug 'mbbill/undotree'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Cocoa: Vim plugin for Cocoa/Objective-C development
Plug 'AlexKornitzer/cocoa.vim', { 'for': ['objc', 'objc++'] }

" Go: Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': ['go'] }

" Javascript: Vastly improved Javascript indentation and syntax support in
" Vim.
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vue'] }

" PS1: A Vim plugin for Windows PowerShell support
Plug 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }

" Rust: Vim configuration for Rust.
" Plug 'rust-lang/rust.vim', { 'for': ['rs'] }
Plug 'rust-lang/rust.vim'

" ALE: Asynchronous Lint Engine
Plug 'w0rp/ale'

" SCSS: Vim syntax file for scss (Sassy CSS) 
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'vue'] }

" TOML: Vim syntax for TOML
Plug 'cespare/vim-toml'

" Typescript: Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" VimVue: Syntax Highlight for Vue.js components
Plug 'posva/vim-vue', { 'for': 'vue' }

" Vimtex: A modern vim plugin for editing LaTeX files.
Plug 'lervag/vimtex', { 'for': 'tex' }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Miscellaneous
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Cscope: A vim plugin to help you to create/update cscope database and connect
"to existing proper database automatically.
Plug 'brookhong/cscope.vim'

" FastFold: Speed up Vim by updating folds only when called-for
" NOTE: Conflicting with rust.vim, and I don't really use folds atm
Plug 'Konfekt/FastFold'

" Misc: Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

" Lessmess: Remove white-space mess from files in ViM
Plug 'mboughaba/vim-lessmess'

" Stay: Make Vim persist editing state without fuss
Plug 'kopischke/vim-stay'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Themes
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Focus: Code editor color theme that lets you focus on the content
Plug 'sindresorhus/focus', { 'rtp': 'vim' }

" Hemisu: A Vim color scheme with dark and light variants
Plug 'noahfrederick/vim-hemisu'

" Jellybeans: A colorful, dark color scheme for Vim
Plug 'nanotech/jellybeans.vim'

" Base16: Base16 for Vim
Plug 'chriskempson/base16-vim'

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

" Enable easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Always show tabline
set laststatus=2
set showtabline=2

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
source $HOME/.vim/settings/ALE.vim                  " Plugin: ALE
source $HOME/.vim/settings/Colorizer.vim            " Plugin: Colorizer
source $HOME/.vim/settings/Gutentags.vim            " Plugin: Gutentags
source $HOME/.vim/settings/FastFold.vim             " Plugin: FastFold
source $HOME/.vim/settings/IndentLine.vim           " Plugin: IndentLine
source $HOME/.vim/settings/Jedi.vim                 " Plugin: Jedi
source $HOME/.vim/settings/LightLine.vim            " Plugin: LightLine
source $HOME/.vim/settings/NERDTree.vim             " Plugin: NERDTree
source $HOME/.vim/settings/Rainbow.vim              " Plugin: Rainbow
source $HOME/.vim/settings/Rust.vim                 " Plugin: Rust
source $HOME/.vim/settings/Tagbar.vim               " Plugin: Tagbar
source $HOME/.vim/settings/UltiSnips.vim            " Plugin: UltiSnips
source $HOME/.vim/settings/Vim-Go.vim               " Plugin: Vim-Go
source $HOME/.vim/settings/Vim-Stay.vim             " Plugin: Vim-Stay
source $HOME/.vim/settings/Vim-Virtualenv.vim       " Plugin: Vim-Virtualenv
source $HOME/.vim/settings/Vimtex.vim               " Plugin: Vimtex
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

" Fix for nasm syntax not being set on *.nasm file type
autocmd BufRead,BufNewFile,Bufenter *.nasm set filetype=nasm

" Fix syntax in vue plugin
autocmd FileType vue syntax sync fromstart

" Enable XML line folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

"-------------------------------------------------------------------------------
" Custom Mappings
"-------------------------------------------------------------------------------

" Location list hotkeys
nmap <leader>lo :lopen<CR>
nmap <leader>lc :lclose<CR>

" Map ale
nmap <leader>lj :ALENext<cr>
nmap <leader>lk :ALEPrevious<cr>
nmap <leader>lf :ALEFix<cr>

" Map fzf
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>

" Map Vimux
nmap <leader>vi :VimuxInspectRunner<CR>
nmap <leader>vl :VimuxRunLastCommand<CR>
nmap <leader>vp :VimuxPromptCommand<CR>
nmap <leader>vs :VimuxInterruptRunner<CR>
nmap <leader>vx :VimuxCloseRunner<CR>
nmap <leader>vz :VimuxZoomRunner<CR>

" Map NERDTree to tt
nmap <leader>tt :NERDTreeToggle<CR>

" Map NERDTreeTabs to ta
nmap <leader>ta :NERDTreeTabsToggle<CR>

" Map Tagbar to tb
nmap <leader>tb :TagbarToggle<CR>

" Map UndoTree
nnoremap <Leader>u :UndotreeToggle<CR>

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
nmap <leader>ts :call SpellToggle()<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Write buffer and delete it
cmap bq w\|bd

" Mirror gt && gT for buffers
map gb :bnext<CR>
map gB :bprev<CR>

" Run python's jtool and set the filetype
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
