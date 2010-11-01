syntax on

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on

"Turn on line numbers
set number
" Turn on the ruler too
set ruler

"Toggle line numbers with <F2>
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" PyDiction
let g:pydiction_location = '~/.vim/vimfiles/ftplugin/pydiction/complete-dict'

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,( 

" CMake
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

set tabstop=4
set shiftwidth=4
set expandtab

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

autocmd FileType make setlocal noexpandtab

set softtabstop=4 " makes the spaces feel like tabs

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

" Colors
colorscheme desert

" Search highlighting
set incsearch
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set smartcase

" Update/Reload vimrc
nmap <Leader>s :source $MYVIMRC<CR>
nmap <Leader>v :e $MYVIMRC<CR>

set history=1000 " remember more commands and search history
set undolevels=1000 " us many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title " Change the terminal's title
" set visualbell "don't beep
" set noerrorbells "don't beep

" No backup files
set nobackup
set noswapfile

" NERDTree
nnoremap FF :NERDTree<CR>

" Perforce
let g:p4Presets = 'cm:1666 jburgess_polo-mac jburgess,cm:1666 jburgess_osx jburgess'
let g:p4EnableRuler = 1
let g:p4ClientRoot = '/Users/jburgess/Perforce/jburgess_osx'
let g:p4EnableActiveStatus = 1

map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

nnoremap <S-U> :redo<CR>

set clipboard=unnamed

set hidden

" Use ; instead of : for entering commands
nnoremap ; :

" Save when losing focus
au FocusLost * :wa
