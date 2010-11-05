" Pathogen Initialization - Must happen first before filetype initialization
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax enable
filetype on
filetype plugin on

set smartindent " Turn on smart indent
set tabstop=4 " Set tab character to 4 characters
set softtabstop=4 " makes the spaces feel like tabs
set shiftwidth=4 " Indent width for autoindent
set expandtab " Tabs to space
filetype indent on " Indent depends on filetype

" F11 to auto indent entire file
nmap <F11> 1G=G
imap <F11> <ESC>1G=Ga

set number " Turn on line numbers
set ruler  " Turn on the ruler too

" Search highlighting
set incsearch
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set ignorecase
set smartcase

"Toggle line numbers with <F2>
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set scrolloff=3

" Colors
colorscheme desert

" Update/Reload vimrc
nmap <Leader>s :source $MYVIMRC<CR>
nmap <Leader>v :e $MYVIMRC<CR>

" No backup files
set nobackup
set noswapfile

" Moving between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Use ; instead of : for entering commands
nnoremap ; :

" Save when losing focus
au FocusLost * :wa

" Use Vim as a hex Editor
map <Leader>hon :%!xxd<CR>
map <Leader>hof :%!xxd -r<CR>

" Get info about the current syntax under the cursor with F10
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" ----------------------------------------
" ----------- Status Line ----------------
set laststatus=2

set statusline=%f       " Tail of filename

" Display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" Display warning if not utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      " help file flag
set statusline+=%y      " filetype
set statusline+=%r      " read-only flag
set statusline+=%m      " modified flag

" Display current git branch
set statusline+=%{fugitive#statusline()}

" Display a warning if &et is wrong or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

" Display [\s] if there is trailing whitespace somewhere
set statusline+=%{StatuslineTrailingSpaceWarning()}

" Display syntastic status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=     " left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \  " Current highlight
set statusline+=%c,     " Cursor column
set statusline+=%l/%L   " current line/total lines
set statusline+=\ %P    " Percent through file

" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

" recalculate the trailing whitespace warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" return '[\s]' if trailing whitespace is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning= '[\s]'
        else
            let b:statusline_trailing_space_warning= ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

" Return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

" Color the status line blue/white
highlight StatusLine ctermfg=White ctermbg=Blue cterm=NONE

" --------------- Other -------------------
" Python
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" CMake
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

autocmd FileType make setlocal noexpandtab

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window
let Tlist_User_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist display config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

set history=1000 " remember more commands and search history
set undolevels=1000 " us many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title " Change the terminal's title
" set visualbell "don't beep
" set noerrorbells "don't beep

" NERDTree
nnoremap FF :NERDTree<CR>

" Perforce
let g:p4Presets = 'cm:1666 jburgess_polo-mac jburgess,cm:1666 jburgess_osx jburgess'
let g:p4EnableRuler = 1
let g:p4ClientRoot = '/Users/jburgess/Perforce/jburgess_osx'
let g:p4EnableActiveStatus = 1

nnoremap <S-U> :redo<CR>

set clipboard=unnamed

set hidden


" -------------------------------------------------------------------------
" CLEANUP BELOW
" -------------------------------------------------------------------------


" PyDiction
let g:pydiction_location = '~/.vim/vimfiles/ftplugin/pydiction/complete-dict'

