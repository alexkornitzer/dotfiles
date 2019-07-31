" ALE
let g:ale_set_highlights = 0

"
" Checker specific
"
let g:ale_fixers = {}

" YAML
let g:ale_fixers.yaml = ['prettier']

" Python
let g:ale_fixers.python = ['black']

" Javascript
let g:ale_fixers.javascript = ['eslint']

" Rust
let g:ale_rust_rls_toolchain = 'stable'
autocmd FileType rust let b:ale_linters = { 'rust': findfile('Cargo.toml', '.;') != '' ? (executable('rls') ? ['rls'] : ['cargo']) : ['rustc'] }
let b:ale_linters = { 'python': ['pyls'] }

" Vue
let g:ale_fixers.vue = ['eslint']
