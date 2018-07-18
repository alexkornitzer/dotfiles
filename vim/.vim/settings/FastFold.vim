" Turn on the folding we would like
let g:vimsyn_folding = 'af'
let g:perl_fold = 1
let g:php_folding = 1
let g:tex_fold_enabled = 1
let g:xml_syntax_folding = 1

" Ignore rs files they conflict with rust.vim
let g:fastfold_skip_filetypes = [ 'rust', 'taglist' ]
