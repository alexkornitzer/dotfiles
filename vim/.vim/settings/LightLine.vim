" LightLine
let g:lightline = {
      \   'colorscheme': 'catppuccin_mocha',
  \ }

" HACK: Incredible inefficient...
augroup LightLineOnLsp
  autocmd!
  autocmd CursorMoved * call lightline#update()
augroup end

" Load components
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'lsp_warnings': 'LspWarnings',
      \  'lsp_errors': 'LspErrors',
      \  'lsp_ok': 'LspOk',
      \ }
let g:lightline.component_function = {
      \  'gitgutter': 'Git',
      \  'fileformat': 'LightlineFileformat',
      \  'filename': 'LightlineFilename',
      \  'filetype': 'LightlineFiletype',
      \  'lessmess': 'Lessmess',
      \  'mode': 'LightlineMode',
      \  'tagbar': 'Tagbar',
      \  'virtualenv': 'VirtualEnv',
      \ }

" Set component colours
let g:lightline.component_type = {
      \     'buffers': 'tabsel',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \     'lsp_warnings': 'warning',
      \     'lsp_errors': 'error',
      \     'lsp_ok': 'left',
      \ }

" Add components
let g:lightline.active = {
  \  'left': [ [ 'mode', 'paste' ],
  \            [ 'virtualenv', 'gitgutter', 'filename' ],
  \            [ 'spell' ] ],
  \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lessmess', 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'tagbar', 'fileformat', 'fileencoding', 'filetype' ] ]
  \}
let g:lightline.tabline = {'left': [['tabs']], 'right': [['close']]}

" Helper functions
function! Git()
  if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead') && FugitiveHead() != ''
    let hunks = GitGutterGetHunkSummary()
    return '+' . hunks[0] . ' ~' . hunks[1] . ' -' . hunks[2]  . ' ⎇ ' . FugitiveHead()
  endif
  return ''
endfunction
function! Lessmess()
  if exists('*lessmess#statusline')
    return lessmess#statusline()
  endif
  return ''
endfunction
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFilename()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? g:lightline.fname :
          \ fname =~ '__Gundo\|NERD_tree' ? '' :
          \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &ft == 'vimshell' ? vimshell#get_status_string() :
          \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
          \ ('' != fname ? fname : '[No Name]') .
          \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineMode()
  return expand('%:t') == '__Tagbar__' ? 'Tagbar':
        \ expand('%:t') =~ 'NERD_tree' ? 'NERDTree' :
        \ &filetype == 'unite' ? 'Unite' :
        \ &filetype == 'vimfiler' ? 'VimFiler' :
        \ &filetype == 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction
function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! LspErrors() abort
  if exists('*lsp#get_buffer_diagnostics_counts')
    let l:diag = lsp#get_buffer_diagnostics_counts()
    return l:diag.error == 0 ? '' : printf('E:' . l:diag.error)
  endif
  return ''
endfunction
function! LspWarnings() abort
  if exists('*lsp#get_buffer_diagnostics_counts')
    let l:diag = lsp#get_buffer_diagnostics_counts()
    return l:diag.warning == 0 ? '' : printf('W:' . l:diag.warning)
  endif
  return ''
endfunction
function! LspOk() abort
  if exists('*lsp#get_buffer_diagnostics_counts')
    let l:diag = lsp#get_buffer_diagnostics_counts()
    return l:diag.error == 0 && l:diag.warning == 0 ? 'OK' : ''
  endif
  return ''
endfunction
function! VirtualEnv()
  if exists('*virtualenv#statusline')
    return virtualenv#statusline()
  endif
  return ''
endfunction
