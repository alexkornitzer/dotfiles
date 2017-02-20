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
