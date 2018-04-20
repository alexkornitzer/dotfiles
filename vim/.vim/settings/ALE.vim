" ALE
let g:ale_set_highlights = 0

" Checker specific
autocmd FileType rust let b:ale_linters = {'rust': findfile('Cargo.toml', '.;') != '' ? ['cargo'] : ['rustc']}
