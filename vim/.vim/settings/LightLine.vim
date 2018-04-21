" LightLine
let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \ }

" Load components
let g:lightline.component_expand = {
      \  'buffers' : 'lightline#bufferline#buffers',
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'tabs': 'LightlineTabs',
      \ }
let g:lightline.component_function = {
      \  'gitgutter': 'Git',
      \  'lessmess': 'Lessmess',
      \  'fileformat': 'LightlineFileformat',
      \  'filename': 'LightlineFilename',
      \  'filetype': 'LightlineFiletype',
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
let g:lightline.tabline = {'left': [['tabs']], 'right': [['close'], ['buffers']]}

" Override colour palette
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
" Override middle to background colour
let s:palette.normal.middle = [ [ '#4e4e43', '#151515', 239, 233 ] ]
let s:palette.inactive.middle = [ [ '#666656', '#151515', 242, 233 ] ]
let s:palette.tabline.middle = [ [ '#4e4e43', '#151515', 239, 233 ] ]
" Override tabline selection
let s:palette.tabline.left = [ [ '#e8e8d3', '#151515', 253, 233 ] ]

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
function! Test()
  return lightline#tabs()
endfunction
function! VirtualEnv()
  if exists('*virtualenv#statusline')
    return virtualenv#statusline()
  endif
  return ''
endfunction
