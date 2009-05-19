" -- basic settings --

set expandtab
set autoindent
set softtabstop=4
set shiftwidth=4
set showmatch
set background=light
set hlsearch
set incsearch
set number

" -- cscope settings --

set cscopetag "use cscope tage for ctrl-]
set csto=0    "search cscope database first
set cst       "search cscope database tags
set csverb    "cscope verbose is helpful

map =csc :!./build_cs.sh<CR>
map =csa :cs add ./cscope.out<CR>

"format current paragraph
map =fmt !}fmt<CR> 


set fileformats=unix,dos
set fileformat=unix

syntax on

