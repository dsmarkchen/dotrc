" vim configuration file
" Last updated: Feb 1, 2013

set nocompatible " Why would I use vim if I wanted it to act like vi?
set noshowmode
set modeline

syntax enable
syntax on 

filetype on
filetype plugin on

"let NIPATH=C:\Program Files (x86)\National Instruments\MeasurementStudioVS2010

if has("gui_running")
"set guifont=Droid_Sans_Mono:h10:cANSI
"colorscheme google

" for laptop with high resolution but not very large screen
"set gfn=Consolas:h12:cANSI

" for dell moniters 1680x1050 
set gfn=Consolas:h9:cANSI

"set gfn=Courier_New:h10:cDEFAULT
"set gfn=ProggyCleanTT:h12:cANSI
colorscheme ir_black
"wintersday
"wombat
"set guioptions=em
set showtabline=2
set lines=40 columns=85
set bg=dark

" gVim specific settings
set guioptions-=T     " Remove the toolbar and menubar
set guioptions-=m
set guioptions-=r     " Remove right- and left-hand scrollbars
set guioptions-=L
set guioptions+=c     " Console-based dialogs for simple queries
 
else
set bg=dark
highlight comment ctermfg=darkgray
highlight constant ctermfg=blue
highlight Identifier ctermfg=lightYellow   " html     <  and   />
highlight search  ctermbg=lightYellow  ctermfg=black
highlight Special ctermfg=Gray
highlight Statment ctermfg=red ctermbg=yellow
highlight Function ctermfg=darkGray   "  begin tag wickets  ,   =
highlight Type ctermfg=Darkgray
highlight Question ctermfg=red ctermbg=blue
highlight NonText ctermfg=darkGray
highlight PreProc ctermfg=darkGray
highlight htmlTitle ctermfg=DarkGray 
endif

" Mappings to jump me to the beginning of functions
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>


set wrap            "turn on word wrapping 
set number          "show number lines
set nuw=4           "the width of number (the lines from 0 to 9999) 

set shiftwidth=4     
set tabstop=4
set softtabstop=4
set expandtab       "expand to spaces
set linebreak       "line breaks for linewrap


set ruler
set showcmd
set showmatch

" For Taglist
nnoremap <silent> <F3> :TlistToggle<CR> 
nnoremap <silent> <F8> :Tlist<CR> 
nnoremap <silent> <F9> :TlistSync<CR>
let Tlist_Use_Right_Window = 1
 
let tlist_cpp_settings = 'c++;c:class;f:function'

" TagListTagName - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue
" TagListTitle - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
" TagListComment - Used for comments
highlight MyTagListComment guifg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue

nmap <silent> <space><space> :! find . -name "*.cpp" -o -name "*.h" -print <CR>

" For DoxygenToolkit


let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_versionTag = "\\version "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_briefTag_pre="\\brief"
let g:DoxygenToolkit_paramTag_pre="\\param "
let g:DoxygenToolkit_returnTag="\\return "
let g:DoxygenToolkit_authorName="Mark Chen <mchen@extremeeng.com>" 
let g:DoxygenToolkit_interCommentTag = " * "
let g:DoxygenToolkit_startCommentTag = "/*! "
let g:DoxygenToolkit_startCommentBlock = "//!< "
let g:DoxygenToolkit_endCommentTag = " */"
let g:DoxygenToolkit_endCommentBlock = ""
let g:DoxygenToolkit_compactDoc = "yes"

map <F2>a :DoxAuthor
map <F2>f :Dox
map <F2>b :DoxBlock
map <F2>c A //!< 

function! SwitchHeaderAndCode()
  let l:basefile = expand("%:t:r")
  let l:ext = expand("%:e")
  let l:oldfile = expand("%")

  if g:lastfile
    exec "find " . g:lastfile 
  elseif l:ext == "cpp" 
    let g:lastfile = expand("%")
    exec "find " . l:basefile . ".h"
  elseif l:ext == "h"
    let g:lastfile = expand("%")
    exec "find " . l:basefile . ".cpp"
  endif
endfunction

function! Markc_highlight()
    let list = taglist('.*')

    for item in list
        let kind = item.kind

        if kind == 'f' || kind == 'c'
            let name = item.name
            exec 'syntax keyword Identifier '.name
        endif
    endfor
endfunction

call Markc_highlight()


" Some plugins like to contain documentation, hurray!
if isdirectory("$VIM/vimfiles/doc")
  helptags $VIM/vimfiles/doc
endif
autocmd BufWritePost $VIM/vimfiles/doc :helptags $VIM/vimfiles/doc
autocmd BufRead markcnotes.txt  set filetype=help
autocmd BufRead markcnotes.txt  set noreadonly
autocmd BufRead markcnotes.txt  set modifiable
nmap ,h :tabnew $VIM/vimfiles/doc/markcnotes.txt<CR>


"set tags+=$HOME/.vim/doc/tags
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/vc.ctags
"set tags+=$HOME/.vim/tags/xbus.ctags 
"set tags+=$HOME/.vim/tags/xconnect.ctags
"set tags+=./tags

"';' at end have vim search go up from current directory until it finds one


set tags=$HOME/.vim/tags/cpp
set tags+=$HOME/.vim/tags/sdk.ctags
set tags+=$HOME/.vim/tags/downhole.ctags
set tags+=./tags

map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

map <F5> :execute "vimgrep /" . expand("<cword>") . "/j **/*.ees **/*.cpp **/*.c **/*.h" <Bar> cw<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **/*.cs **/*.cpp **/*.cc **/*.c **/*.h **/*.w" <Bar> cw<CR>
map <s-F4>  :execute "vimgrep /" . expand("<cword>") . "/j ../**/*.cpp **/*.cc ../**/*.c ../**/*.h" <Bar> cw<CR>

function! MC_create_tag()
  let l:ctags_cmd = 'ctags'
  let l:proj_path = shellescape(expand("%:p:h"))
  let l:ctags_args = " --c++-kinds=+p --fields=+iaS --extra=+q --recurse "
  let l:ctags_str = l:ctags_cmd . l:ctags_args . "-f " . l:proj_path . "/tags " . l:proj_path
  call system(l:ctags_str)
  "return l:ctags_str
endfunction

nmap ,a :call MC_create_tag()


"let my_niinc = $NIPATH/VCNET/Include
nmap ,t :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q  -f $NIPATH/VCNET/include *.cpp *.h <CR>



