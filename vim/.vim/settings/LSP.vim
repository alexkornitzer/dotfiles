" General
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_insert_text_enabled = 0
let g:lsp_signs_enabled = 1
let g:lsp_text_edit_enabled = 0


let g:lsp_settings = {
\   'texlab': {
\     'workspace_config': {
\       'texlab': {
\         'build': {
\           'args': [
\             "-pdf",
\             "-interaction=nonstopmode",
\             "-synctex=1",
\             "-pv",
\             "%f"
\           ],
\           'forwardSearchAfter': v:true,
\           'onSave': v:true
\         },
\         'chktex': {
\           'onOpenAndSave': v:true
\         },
\         'forwardSearch': {
\           'executable': '',
\           'args': []
\         }
\       }
\     }
\   }
\ }

if has('macunix')
  let g:lsp_settings['texlab']['workspace_config']['texlab']['forwardSearch']['executable'] = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:lsp_settings['texlab']['workspace_config']['texlab']['forwardSearch']['args'] = ["-g", "%l", "%p", "%f"]
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>ld <Plug>(lsp-document-diagnostic)
    nmap <buffer> <leader>lk <Plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>lj <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
