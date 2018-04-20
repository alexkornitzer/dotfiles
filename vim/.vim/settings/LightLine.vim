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
      \ }
let g:lightline.component_function = {
      \  'gitgutter': 'Git',
      \  'lessmess': 'Lessmess',
      \  'tagbar': 'Tagbar',
      \  'virtualenv': 'VirtualEnv',
      \ }

" Set component colours
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

" Add components
let g:lightline.active = {
  \  'left': [ [ 'mode', 'paste' ],
  \            [ 'virtualenv', 'gitgutter', 'readonly', 'filename', 'modified' ] ],
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
  if exists('*fugitive#head') && fugitive#head() != ''
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
function! Tagbar()
  if exists('*tagbar#currenttag')
    return tagbar#currenttag("%s", "", "f")
  endif
  return ''
endfunction
function! VirtualEnv()
  if exists('*virtualenv#statusline')
    return virtualenv#statusline()
  endif
  return ''
endfunction
