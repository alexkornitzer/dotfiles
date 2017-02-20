" The Colors -----------------------------------------------{{{
" Define reusable colors
let s:black            = { "gui": "#000000", "cterm": "16"  }
let s:white            = { "gui": "#FFFFFF", "cterm": "231" }
let s:almostWhite      = { "gui": "#EEEEEE", "cterm": "255" }
let s:almostBlack      = { "gui": "#111111", "cterm": "233" }
let s:middleDarkGrey   = { "gui": "#777777", "cterm": "241" }
let s:middleLightGrey  = { "gui": "#999999", "cterm": "246" }
let s:lightGrey        = { "gui": "#BBBBBB", "cterm": "249" }
let s:darkGrey         = { "gui": "#444444", "cterm": "238" }

let s:darkPink         = { "gui": "#63001C", "cterm": "88"  }
let s:middleDarkPink   = { "gui": "#FF0055", "cterm": "197" }
let s:middleLightPink  = { "gui": "#D65E76", "cterm": "167" }
let s:lightPink        = { "gui": "#FFAFAF", "cterm": "217" }

let s:darkBlue         = { "gui": "#005F87", "cterm": "24"  }
let s:middleDarkBlue   = { "gui": "#538192", "cterm": "24"  }
let s:middleLightBlue  = { "gui": "#9FD3E6", "cterm": "116" }
let s:lightBlue        = { "gui": "#CBE4EE", "cterm": "195" }

let s:darkGreen        = { "gui": "#5F5F00", "cterm": "58"  }
let s:middleDarkGreen  = { "gui": "#739200", "cterm": "64"  }
let s:middleLightGreen = { "gui": "#B1D631", "cterm": "149" }
let s:lightGreen       = { "gui": "#BBFFAA", "cterm": "157" }

let s:darkTan          = { "gui": "#503D15", "cterm": "52"  }
let s:lightTan         = { "gui": "#ECE1C8", "cterm": "230" }

" Normal mode
let s:N1 = [ '#ffffff' , '#B1D631' , 255 , 238 ]
let s:N2 = [ '#1C1C1C' , '#ffffff' , 235 , 255 ]
let s:N3 = [ '#ffffff' , '#1C1C1C' , 255 , 235 ]

" Insert mode
let s:I1 = [ '#ffffff' , '#D65E76' , 235 , 149 ]
let s:I2 = [ '#1C1C1C' , '#ffffff' , 235 , 255 ]
let s:I3 = [ '#ffffff' , '#1C1C1C' , 255 , 235 ]

" Visual mode
let s:V1 = [ '#000000' , '#005F87' , 255 ,  24 ]
let s:V2 = [ '#1C1C1C' , '#ffffff' , 235 , 255 ]
let s:V3 = [ '#ffffff' , '#1C1C1C' , 255 , 235 ]

" Replace mode
let s:R1 = [ '#000000' , '#9FD3E6' , 235 , 195 ]
let s:R2 = [ '#1C1C1C' , '#ffffff' , 235 , 255 ]
let s:R3 = [ '#ffffff' , '#1C1C1C' , 255 , 235 ]

let g:airline#themes#hemisu_dark#palette = {}
let g:airline#themes#hemisu_dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#hemisu_dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#hemisu_dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#hemisu_dark#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive mode
let s:IN1 = [ '#585858' , '#1C1C1C' , 246 , 235 , '' ]
let s:IN2 = [ '#585858' , '#1C1C1C' , 246 , 235 , '' ]
let s:IN3 = [ '#585858' , '#1C1C1C' , 246 , 235 , '' ]

let g:airline#themes#hemisu_dark#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

" Accents
let g:airline#themes#hemisu_dark#palette.accents = {
      \ 'red': [ '#63001C' , '#FFFFFF' , 255, 88 , ''  ]
      \ }

" Tabline
let g:airline#themes#hemisu_dark#palette.tabline = {
      \ 'airline_tab':     [ '#D65E76' , '#ffffff' ,  246 , 238  , '' ],
      \ 'airline_tabsel':  [ '#ED0028' , '#ffffff' ,  235 , 255  , '' ],
      \ 'airline_tabtype': [ '#ED0028' , '#ffffff' ,  235 , 195  , '' ],
      \ 'airline_tabfill': [ '#000000' , '#ffffff' ,  15  , 16   , '' ],
      \ 'airline_tabmod':  [ '#7E40A5' , '#ffffff' ,  235 , 195  , '' ]
      \ }

" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif

let s:CP1 =  [ '#D65E76' , '#ffffff' , 235 , 217 ]
let s:CP2 =  [ '#ED0028' , '#ffffff' , 235 , 255 ]
let s:CP3 =  [ '#ffffff' , '#FF0055' , 255 , 235 ]

let g:airline#themes#hemisu_dark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(s:CP1, s:CP2, s:CP3)

