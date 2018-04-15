let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'govet']
let g:syntastic_objc_compiler = 'clang'
let g:syntastic_objc_checkers = ['clang', 'gcc']
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_tex_chktex_args = "-g1"
let g:syntastic_vue_checkers = ['eslint']

" Checker specific
autocmd FileType rust let b:syntastic_checkers = findfile('Cargo.toml', '.;') != '' ? ['cargo'] : ['rustc']

" Show errors with `
nnoremap <silent> ` :Errors<CR>
