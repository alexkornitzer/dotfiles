" Checker specific
autocmd FileType rust let b:ale_linters = {'rust': findfile('Cargo.toml', '.;') != '' ? ['cargo'] : ['rustc']}
