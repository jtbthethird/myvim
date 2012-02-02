" Pathogen {
" Pathogen Initialization - Must happen first before filetype initialization
    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()
" }


" Basics {
    set nocompatible    " Explicitly get out of vi-compatible mode
    syntax enable       " Syntax highlighting ON
" }


" General {
    filetype on         " Load filetype settings
    filetype plugin on  " Load filetype plugins
    filetype indent on  " load filetype indent settings

    set smartindent     " Turn on smart indent
    set tabstop=4       " Set tab character to 4 characters
    set softtabstop=4   " makes the spaces feel like tabs
    set shiftwidth=4    " Indent width for autoindent
    set expandtab       " Tabs to space

    set number          " Turn on line numbers
    set ruler           " Turn on the ruler too

    " Search highlighting
    set incsearch
    set hlsearch
    set ignorecase
    set smartcase

    set scrolloff=3     " Leave 3 lines at the top and buttom

    set nobackup        " No backup files
    set noswapfile      " No swap files

    " Save when losing focus
    au FocusLost * :wa

    set hidden          " Hide buffers when they are abandoned

    set showcmd         " Show the current command in the status bar
" }


" Colors {
    colorscheme desert
" }


" Moving around {
    " Moving between splits
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-H> <C-W>h
    map <C-L> <C-W>l
" }


" Status Line {
    set laststatus=2        " Always show the statusline

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

" -----------------------------------------
" ------------- Remap Keys ----------------

" Leader Remappings {
    " Leader = ","
    let mapleader = ","

    " Update/Reload vimrc
    " ,s = Source vimrc
    " ,v = Edit vimrc
    nmap <Leader>s :source $MYVIMRC<CR>
    nmap <Leader>v :e $MYVIMRC<CR>

    " Use Vim as a hex Editor
    " ,hon = turn Hex editor on
    " ,hof = turn Hex editor off
    map <Leader>hon :%!xxd<CR>
    map <Leader>hof :%!xxd -r<CR>
"}

" F-Key Remapping {
    " F1

    " F2 = Toggle line numbers
    nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

    " F3 = Toggle paste mode
    set pastetoggle=<F3>

    " F4

    " F5

    " F6

    " F7

    " F8

    " F9

    " F10 = Get info about the current syntax under the cursor
    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

    " F11 = auto indent entire file
    nmap <F11> 1G=G
    imap <F11> <ESC>1G=Ga

    " F12
"}


" Other remapping {
    " U = Redo
    nnoremap <S-U> :redo<CR>

    " Space = turn off current higlight
    nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

    " ; = : for entering commands
    nnoremap ; :

    " w!! = Save with sudo
    cmap w!! w !sudo tee % > /dev/null

    " FF = NERDTree
    nnoremap FF :NERDTreeToggle<CR>

    " # = Don't unindent # for Python comments
    inoremap # X#

    " jj = Escape from insert mode
    inoremap jj <Esc>

    " j = Move by screen line instead of file line
    " k = Move by screen line instead of file line
    nnoremap j gj
    nnoremap k gk

" }
" -----------------------------------------
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

set history=1000 " remember more commands and search history
set undolevels=1000 " us many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title " Change the terminal's title
" set visualbell "don't beep
" set noerrorbells "don't beep

" Perforce
let g:p4Presets = 'cm:1666 jburgess_polo-mac jburgess,cm:1666 jburgess_osx jburgess'
let g:p4EnableRuler = 1
let g:p4ClientRoot = '/Users/jburgess/Perforce/jburgess_osx'
let g:p4EnableActiveStatus = 1


