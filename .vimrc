" vim configuration file
" Last updated: Dec 2rd, 2010

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
set lines=40 columns=99
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
"set list

" Some useful miscellaneous options
set listchars=tab:>-        " In case I want to use the 'list' option
set matchpairs+=<:>                 " match < > with the % command, too
set complete=.,w,b,i,t,u          " For great completion justice...
set backspace=indent,eol            " allow rational backspacing in insert mode
set formatoptions=tcrqn
set comments=b:#                    " Most of my files use # for comments


let c_gnu=1
let c_comment_string=1
"let c_space_errors=1

" Only useful if using windows
" Opens gvim using the entire screen
autocmd GuiEnter * simalt ~x
 

autocmd FileType *      set formatoptions=tcql nocindent
autocmd FileType c,cpp  set formatoptions=croql cindent comments=sl:/**,mb:\ *,elx:\ */,bO:///,O://
autocmd FileType c,cpp  set cinoptions=g0,t0
autocmd FileType c,cpp  set isk+=#        " so #if is considered as a key word
autocmd FileType c,cpp  syn keyword cType uint8_t uint32_t
" Highlight Class and Function names
autocmd FileType c,cpp syn match    cCustomParen    "(" contains=cParen,cCppParen
autocmd FileType c,cpp syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
autocmd FileType cpp syn match    cCustomScope    "::"
autocmd FileType cpp syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
autocmd FileType c,cpp let Tlist_Ctags_Cmd = 'ctags.exe --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
autocmd FileType cweb set omnifunc=ccomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

"autocmd FileType c,cpp syn match defined "[A-Z][A-Z0-9_]*\ " 
"hi def link defined constant
hi def link cCustomFunc  Function
hi def link cCustomClass Function
	
setlocal define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)



"set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://

nnoremap <silent> <space>t :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
 

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

 
" For File Browser
nnoremap <silent> <F12> :Exp<CR>
 
" auto-change the directory to the current buffer
autocmd BufEnter * :cd %:p:h

" BufExplorer
nnoremap <silent> <F11> :BufExplorer<CR>

set suffixes=.bak,~,.o,.info,.swp,.obj

let g:explHideFiles='\.swp$'


let g:lastfile = ""
nmap <space>s :call SwitchHeaderAndCode()<CR>


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


map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **/*.cpp **/*.cc **/*.c **/*.h **/*.w" <Bar> cw<CR>
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



au BufNewFile,BufRead *.cpp,*.c,*.h,*.java syn region myCComment start="/\*" end="\*/" fold keepend transparent

set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '^[\t ]*', '', '')
  let nlines = v:foldend - v:foldstart + 1
  if strlen(nlines) == 1
    let nlines = " " . nlines
  elseif strlen(nlines) == 2
    let nlines = " " . nlines
  endif
  return "+-" . v:folddashes . nlines . ": " . sub
endfunction


" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*' 

let g:neocomplcache_enable_at_startup = 0
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string() 

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "ATL"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
 
