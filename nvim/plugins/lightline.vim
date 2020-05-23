
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
   let branch = gitbranch#name()
   return branch !=# '' ? ' '.branch : ''
endfunction

" ============================================================
" nightowl
" ============================================================

let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#112630", 235], ["#82aaff", 111]], [["#d6deeb", 253], ["#112630", 235]]]
let s:p.normal.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.normal.right = [[["#d6deeb", 253], ["#112630", 235]], [["#112630", 235], ["#82aaff", 111]]]
let s:p.normal.error = [[["#112630", 235], ["#82aaff", 111]]]
let s:p.normal.warning = [[["#112630", 235], ["#82aaff", 111]]]

let s:p.inactive.left = [[["#d6deeb", 253], ["#112630", 235]], [["#d6deeb", 253], ["#112630", 235]]]
let s:p.inactive.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.inactive.right = [[["#d6deeb", 253], ["#112630", 235]], [["#d6deeb", 253], ["#112630", 235]]]

let s:p.insert.left = [[["#112630", 235], ["#addb67", 149]], [["#d6deeb", 253], ["#112630", 235]]]
let s:p.insert.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.insert.right = [[["#d6deeb", 253], ["#112630", 235]], [["#112630", 235], ["#addb67", 149]]]

let s:p.replace.left = [[["#112630", 235], ["#ff5874", 204]], [["#d6deeb", 253], ["#112630", 235]]]
let s:p.replace.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.replace.right = [[["#d6deeb", 253], ["#112630", 235]], [["#112630", 235], ["#ff5874", 204]]]

let s:p.visual.left = [[["#112630", 235], ["#c792ea", 176]], [["#d6deeb", 253], ["#112630", 235]]]
let s:p.visual.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.visual.right = [[["#d6deeb", 253], ["#112630", 235]], [["#112630", 235], ["#c792ea", 176]]]

let s:p.tabline.left = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.tabline.tabsel = [[["#112630", 235], ["#82aaff", 111]]]
let s:p.tabline.middle = [[["#d6deeb", 253], ["#112630", 235]]]
let s:p.tabline.right = [[["#d6deeb", 253], ["#ff5874", 204]]]

let g:lightline#colorscheme#nightowl#palette = lightline#colorscheme#flatten(s:p)

let g:lightline = {
\   'colorscheme': 'nightowl',
\   'mode_map': {
\     'n' : 'N',
\     'i' : 'I',
\     'R' : 'R',
\     'v' : 'V',
\     'V' : 'VL',
\     "\<C-v>": 'VB',
\     'c' : 'C',
\     's' : 'S',
\     'S' : 'SL',
\     "\<C-s>": 'SB',
\     't': 'T',
\   },
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'fugitive', 'filename', 'readonly', 'modified' ],
\              [ 'gitdiff' ] ],
\     'right': [ [ 'lineinfo' ],
\              [ 'percent' ] ],
\   },
\   'inactive': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'fugitive', 'filename', 'readonly', 'modified' ],
\              [ 'gitdiff' ] ],
\     'right': [ [ 'lineinfo' ],
\              [ 'percent' ] ],
\   },
\   'component_function': {
\     'readonly': 'LightlineReadonly',
\     'fugitive': 'LightlineFugitive',
\   },
\   'tabline': {'left': [['buffers']], 'right':[]},
\   'component_expand': {
\     'buffers': 'lightline#bufferline#buffers',
\     'gitdiff': 'lightline#gitdiff#get',
\   },
\   'component_type': {
\     'buffers': 'tabsel',
\     'gitdiff': 'middle',
\   },
\ }

autocmd BufWritePost,TextChanged,TextChangedI,TermLeave * call lightline#update()

