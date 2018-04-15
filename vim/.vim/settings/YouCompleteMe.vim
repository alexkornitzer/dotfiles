" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
" Set rust path if possible
if executable('rustc')
  let g:ycm_rust_src_path = systemlist('rustc --print sysroot')[0] . '/lib/rustlib/src/rust/src'
endif

" Use Syntastic
let g:ycm_register_as_syntastic_checker=0
let g:ycm_show_diagnostics_ui = 0
