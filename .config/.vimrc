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
inoremap jk <Esc>

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

" Vim Tree
nnoremap <leader>e :Explore<CR>

" Faster line navigation
nnoremap H ^
nnoremap L $

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor centered when searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Paste without overwriting register
vnoremap p "_dP

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Quick vertical split and switch
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
