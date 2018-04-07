" Taken from https://github.com/fatih/vim-go/blob/master/ftplugin/go/tagbar.vim due to lack of vimplug support
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : $HOME."/.go/bin/gotags",
  \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_objc = {
  \ 'ctagstype' : 'objectivec',
  \ 'kinds'     : [
    \ 'i:Interface',
    \ 'I:Implementation',
    \ 'p:Protocol',
    \ 'm:Object Method',
    \ 'c:Class Method',
    \ 'v:Global Variable',
    \ 'F:Object Field',
    \ 'f:Function',
    \ 'p:Property',
    \ 't:Type Alias',
    \ 's:Type Structure',
    \ 'e:Enumeration',
    \ 'M:Preprocessor Macro'
  \ ]
\ }

let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:headings',
    \ 'l:links',
    \ 'i:images'
  \ ],
  \ "sort" : 0
\ }

let g:tagbar_type_rust = {
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
    \'T:types,type definitions',
    \'f:functions,function definitions',
    \'g:enum,enumeration names',
    \'s:structure names',
    \'m:modules,module names',
    \'c:consts,static constants',
    \'t:traits',
    \'i:impls,trait implementations',
  \]
\}
