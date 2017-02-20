" Look for a 'local' spell file
let b:spellfile = expand('%:p:h').'/.vimspell.utf-8.add'
if filereadable(b:spellfile)
    let &l:spellfile=b:spellfile
    setlocal spell
    setlocal spelllang=en_gb
else
   setlocal spellfile=
endif
