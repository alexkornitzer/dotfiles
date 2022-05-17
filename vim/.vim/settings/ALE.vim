" ALE
"let g:ale_set_highlights = 0

"
" Checker specific
"
let g:ale_fixers = {}
let g:ale_linters = {}

" Elixir
let g:ale_fixers.elixir = ['mix_format']

" YAML
let g:ale_fixers.yaml = ['yamlfix']

" Python
let g:ale_fixers.python = ['black']
let g:ale_linters.python = []  " NOTE: We use vim-lsp

" Javascript
let g:ale_fixers.javascript = ['eslint']

" Rust
let g:ale_linters.rust = []  " NOTE: We use vim-lsp

" Svelte
let g:ale_fixers.svelte = ['eslint']
let g:ale_linters.svelte = ['eslint']

" Vue
let g:ale_fixers.vue = ['eslint']
