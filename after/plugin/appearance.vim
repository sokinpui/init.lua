"    Appearance
"set background=dark

syntax on

set termguicolors

"  statusline setting
set statusline=%<%F\ %h%m%r%=%-5.(%l,%c-%v%)\ %p%% " more setting in pack directory
set laststatus=2

" I like block blink cursor
set guicursor=i-n-v-c-sm:block,r-cr-o:hor50,a:blinkon100
set guicursor+=a:blinkon100

" cursor shape
"let &t_SR = "\e[4 q" "SR = REPLACE mode
"let &t_EI = "\e[2 q" "EI = NORMAL mode (ELSE)
"let &t_SI = "\e[6 q" "SI = INSERT mode

"    Highlight
"  Search
set incsearch
set hlsearch
set ignorecase
set smartcase
autocmd insertenter * set nohlsearch
autocmd textchanged * set nohlsearch

" highlight yanked text
"autocmd! TextYankPost * silent! lua vim.highlight.on_yank()
"autocmd! TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}

set scrolloff=8
set nocursorline

" auto hide and show cursorline when leave windows
"augroup CursorLine
"    au!
"    au VimEnter * setlocal cursorline
"    au WinEnter * setlocal cursorline
"    au BufWinEnter * setlocal cursorline
"    au WinLeave * setlocal nocursorline
"augroup END

set listchars=space:⋅