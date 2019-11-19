" LightLine
let g:lightline = {
  \   'colorscheme': 'base16_tomorrow_night',
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
      \  'tabs': 'LightlineTabs',
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
  \ 'right': [ [ 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lessmess', 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'tagbar', 'fileformat', 'fileencoding', 'filetype' ] ]
  \}
let g:lightline.tabline = {'left': [['tabs']], 'right': [['close']]}

" Colorscheme
let s:base00 = [ '#1d1f21',  0 ]
let s:base01 = [ '#282a2e', 18 ]
let s:base02 = [ '#373b41', 19 ]
let s:base03 = [ '#969896',  8 ]
let s:base04 = [ '#b4b7b4', 20 ]
let s:base05 = [ '#c5c8c6',  7 ]
let s:base06 = [ '#e0e0e0', 21 ]
let s:base07 = [ '#ffffff', 15 ]
let s:base08 = [ '#cc6666',  1 ]
let s:base09 = [ '#de935f', 16 ]
let s:base0A = [ '#f0c674',  3 ]
let s:base0B = [ '#b5bd68',  2 ]
let s:base0C = [ '#8abeb7',  6 ]
let s:base0D = [ '#81a2be',  4 ]
let s:base0E = [ '#b294bb',  5 ]
let s:base0F = [ '#a3685a', 17 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left     = [ [ s:base01, s:base03 ], [ s:base05, s:base02 ] ]
let s:p.insert.left     = [ [ s:base00, s:base0D ], [ s:base05, s:base02 ] ]
let s:p.visual.left     = [ [ s:base00, s:base09 ], [ s:base05, s:base02 ] ]
let s:p.replace.left    = [ [ s:base00, s:base08 ], [ s:base05, s:base02 ] ]
let s:p.inactive.left   = [ [ s:base02, s:base00 ] ]
let s:p.normal.middle   = [ [ s:base05, s:base00 ] ]
let s:p.inactive.middle = [ [ s:base01, s:base00 ] ]
let s:p.normal.right    = [ [ s:base01, s:base03 ], [ s:base03, s:base02 ] ]
let s:p.inactive.right  = [ [ s:base01, s:base00 ] ]
let s:p.normal.error    = [ [ s:base07, s:base08 ] ]
let s:p.normal.warning  = [ [ s:base07, s:base09 ] ]
let s:p.tabline.left    = [ [ s:base05, s:base01 ] ]
let s:p.tabline.middle  = [ [ s:base05, s:base00 ] ]
let s:p.tabline.right   = [ [ s:base05, s:base02 ] ]
let s:p.tabline.tabsel  = [ [ s:base05, s:base02 ] ]
let g:lightline#colorscheme#base16_tomorrow_night#palette = lightline#colorscheme#flatten(s:p)

" Helper functions
function! Git()
  if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head') && fugitive#head() != ''
    let hunks = GitGutterGetHunkSummary()
    return '+' . hunks[0] . ' ~' . hunks[1] . ' -' . hunks[2]  . ' ⎇ ' . fugitive#head()
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
function! LightlineTabs() abort
  let [x, y, z] = [[], [], []]
  let nr = tabpagenr()
  let cnt = tabpagenr('$')
  for i in range(1, cnt)
    call add(i < nr ? x : i == nr ? y : z,
          \ '%' . i . '%%{lightline#onetab(' . i . ',' . (i == nr) . ')}'
          \ . (i == cnt ? '%T' : ''))
  endfor
  if len(x) > 3
    let x = x[len(x)-3:]
    let x[0] = '<' . x[0]
  endif
  if len(z) > 3
    let z = z[:2]
    let z[len(z)-1] = z[len(z)-1] . '>'
  endif
  return [x, y, z]
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
