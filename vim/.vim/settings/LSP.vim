" General
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_insert_text_enabled = 0
let g:lsp_signs_enabled = 1
let g:lsp_text_edit_enabled = 0

" LSP Systems
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->['rust-analyzer']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
      \ 'whitelist': ['rust'],
      \ 'blacklist': [],
      \ 'workspace_config': {},
      \ 'semantic_highlight': {},
      \ })
  function! s:rust_analyzer_apply_source_change(context)
      let l:command = get(a:context, 'command', {})

      let l:workspace_edit = get(l:command['arguments'][0], 'workspaceEdit', {})
      if !empty(l:workspace_edit)
          call lsp#utils#workspace_edit#apply_workspace_edit(l:workspace_edit)
      endif

      let l:cursor_position = get(l:command['arguments'][0], 'cursorPosition', {})
      if !empty(l:cursor_position)
          call cursor(lsp#utils#position#lsp_to_vim('%', l:cursor_position))
      endif
  endfunction
  call lsp#register_command('rust-analyzer.applySourceChange', function('s:rust_analyzer_apply_source_change'))
elseif executable('rls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'rls',
    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
    \ 'whitelist': ['rust'],
    \ })
endif

if executable('elixir-ls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'elixir-ls',
    \ 'cmd': {server_info->['elixir-ls']},
    \ 'whitelist': ['elixir'],
    \ })
endif

if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif

if executable('svelteserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'svelteserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'svelteserver --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['svelte'],
    \ })
endif

if executable('vls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'vue-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vls --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['vue'],
    \ })
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
