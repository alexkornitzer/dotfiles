" General Settings
let g:LatexBox_custom_indent = 0

"enable background latexmk
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=0
let g:LatexBox_output_type="pdf"

"latexmk options to be able to run commands and get output on the file
let g:LatexBox_latexmk_options="-shell-escape -enable-write18"

"Open files with Skim
let g:LatexBox_viewer="/Applications/Skim.app"

"inline math completion
"let g:LatexBox_complete_inlineMath=1

"enable folding
"let g:LatexBox_folding=1
"let g:LatexBox_fold_text=1
"let g:LatexBox_fold_preamble=1

" use custom mappings instead those provided by default
let g:LatexBox_no_mappings=1

nnoremap <Leader>ll :Latexmk!<CR>
nnoremap <Leader>lp :LatexmkStop<CR>
nnoremap <Leader>lv :LatexView<CR>

"autocmd FileType latex,tex setlocal spell

map <silent> <Leader>ls :silent
      \ !/Applications/Skim.app/Contents/SharedSupport/displayline
      \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p" <CR>
