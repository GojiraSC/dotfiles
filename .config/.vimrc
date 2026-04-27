" Basic settings
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrap
set scrolloff=8
set signcolumn=no
set noswapfile

" Better backspace behavior
set backspace=indent,eol,start

" Show matching brackets
set showmatch

" Syntax and colors
syntax on
set background=dark

" Keymaps
let mapleader = " "

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Quick save/quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
