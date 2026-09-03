set nocompatible

" --- Plugins (vim-plug) -----------------------------------------------------
" Bootstrap vim-plug on first run, then install plugins. Needs curl.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

filetype plugin indent on

" --- Settings ---------------------------------------------------------------

" Add status line, disable showing mode (lightline does it for us)
set laststatus=2
set noshowmode

" Enable syntax highlighting
syntax enable

" Configure colorscheme
colorscheme moody

" Configure vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1

" Default to utf-8, unix-style, allow reading of dos files
set encoding=utf-8
set fileformats=unix,dos

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Show a visual line under the cursor's current line
set cursorline

" Show the matching part of the pair for [] {} and ()
set showmatch

" Add vertical line
set colorcolumn=80

" Mark EOL whitespace as bad
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.rs match BadWhitespace /\s\+$/

" Configuration for .py files
autocmd BufNewFile,BufRead *.py
    \ let python_highlight_all = 1 |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set number
