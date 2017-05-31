" Add status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
set laststatus=2

" Enable syntax highlighting
syntax enable

" Default to utf-8, unix-style, allow reading of dos files
set encoding=utf-8
set fileformats=unix,dos

" Show a visual line under the cursor's current line
set cursorline

" Show the matching part of the pair for [] {} and ()
set showmatch

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Set colors for a dark background
set background=dark

" Set default text width and add vertical line
set textwidth=79
set colorcolumn=80

" Press F9 to execute current buffer
nnoremap <F9> :!%:p<Enter>

" Configuration for .py files
autocmd BufNewFile *.py
    \ 0r ~/.vim/skeleton.py

autocmd BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set number

