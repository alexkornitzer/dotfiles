" ALE
let g:ale_set_highlights = 0
let g:ale_fixers = { 'javascript': ['eslint'], 'vue': ['eslint'] }

"
" Checker specific
" 
let g:ale_fixers = {}

" Javascript
let g:ale_fixers.javascript = ['eslint']

" Rust
let g:ale_rust_rls_toolchain = 'stable'
autocmd FileType rust let b:ale_linters = { 'rust': findfile('Cargo.toml', '.;') != '' ? ['rls', 'cargo'] : ['rustc'] }

" Vue
let g:ale_fixers.javascript = ['eslint']

