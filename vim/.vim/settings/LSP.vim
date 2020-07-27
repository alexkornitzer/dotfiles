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
  autocmd FileType rust setlocal omnifunc=lsp#complete
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
  autocmd FileType rust setlocal omnifunc=lsp#complete
endif

if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
  autocmd FileType python setlocal omnifunc=lsp#complete
endif

if executable('sls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'svelte-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'sls --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['svelte'],
    \ })
  autocmd FileType svelte setlocal omnifunc=lsp#complete
endif

if executable('vls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'vue-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vls --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['vue'],
    \ })
  autocmd FileType vue setlocal omnifunc=lsp#complete
endif
