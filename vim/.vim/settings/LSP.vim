" General

" LSP Systems
if executable('vls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'vue-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vls --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['vue'],
    \ })
  autocmd FileType vue setlocal omnifunc=lsp#complete
endif