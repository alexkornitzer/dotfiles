" General
let g:mucomplete#enable_auto_at_startup = 1

" Chain Settings
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['file', 'omni', 'keyn', 'dict', 'ulti']
let g:mucomplete#chains.unite = []

"
" Language Specific
"
let g:mucomplete#can_complete = {}

" Rust
let g:mucomplete#can_complete.rust = {
  \  'omni': { t -> strlen(&l:omnifunc) > 0 && t =~# '\%(\k\:\:\|\k\.\)$' }
  \ }

" Vue
let g:mucomplete#can_complete.vue = {
  \  'omni': { t -> strlen(&l:omnifunc) > 0 && t =~# '\%(\k\.\)$' }
  \ }
