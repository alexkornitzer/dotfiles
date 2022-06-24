let s:base = '#1E1E2E'
let s:mantle = '#181825'

let s:overlay0 = '#6C7086'
let s:surface0 = '#313244'
let s:surface1 = '#45475A'

let s:blue = '#89B4FA'
let s:mauve = '#CBA6F7'
let s:red = '#F38BA8'
let s:teal = '#94E2D5'
let s:yellow = '#F9E2AF'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:mantle, s:blue ], [ s:blue, s:base ] ]
let s:p.normal.middle = [ [ s:blue, s:surface1 ] ]
let s:p.normal.right = [ [ s:overlay0, s:base ], [ s:blue, s:surface0 ] ]
let s:p.normal.error = [ [ s:mantle, s:red ] ]
let s:p.normal.warning = [ [ s:mantle, s:yellow ] ]

let s:p.insert.left = [ [ s:mantle, s:teal ], [ s:blue, s:base ] ]

let s:p.visual.left = [ [ s:mantle, s:mauve ], [ s:blue, s:base ] ]

let s:p.replace.left = [ [ s:mantle, s:red ], [ s:blue, s:base ] ]

let s:p.inactive.right = [ [ s:blue, s:base ], [ s:overlay0, s:base ] ]
let s:p.inactive.middle = [ [ s:surface1, s:base ] ]
let s:p.inactive.left =  [ [ s:surface1, s:base ], [ s:overlay0, s:base ] ]

let s:p.tabline.left = [ [ s:overlay0, s:base ], [ s:overlay0, s:base ] ]
let s:p.tabline.middle = [ [ s:surface0, s:base ] ]
let s:p.tabline.right = [ [ s:surface1, s:base ], [ s:overlay0, s:base] ]
let s:p.tabline.tabsel = [ [ s:blue, s:surface1 ], [ s:overlay0, s:base ] ]

let g:lightline#colorscheme#catppuccin#palette = lightline#colorscheme#fill(s:p)
