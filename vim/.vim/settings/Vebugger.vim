" General
let g:vebugger_leader = "<Leader>d"

" Pin height of the shell
au BufFilePost Vebugger:Shell set wfh

" Debuggers
au FileType * let g:vebugger_path_gdb = "gdb"
au FileType rust let g:vebugger_path_gdb = "rust-gdb"
