" ALE
let g:ale_set_highlights = 0

"
" Checker specific
"
let g:ale_fixers = {}
let g:ale_linters = {}

" YAML
let g:ale_fixers.yaml = ['prettier']

" Python
let g:ale_fixers.python = ['black']
let g:ale_linters.python = ['pyls']

" Javascript
let g:ale_fixers.javascript = ['eslint']

" Rust
let g:ale_rust_rls_toolchain = 'stable'
autocmd FileType rust let b:ale_linters = {'rust': findfile('Cargo.toml', '.;') != '' ? (executable('rls') ? ['rls'] : ['cargo']) : ['rustc'] }

" Svelte
let g:ale_linter_aliases = {'svelte': ['svelte', 'javascript', 'css', 'html']}
let g:ale_fixers.svelte = ['eslint', 'prettier', 'prettier_standard']
let g:ale_linters.svelte = ['eslint']

" Vue
let g:ale_fixers.vue = ['eslint']
