" Enable syntax highlighting
syntax enable

" Show a visual line under the cursor's current line
set cursorline

" Show the matching part of the pair for [] {} and ()
set showmatch

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Set colors for a dark background
set background=dark

" Set default text width
set textwidth=79

" Configuration for .py files
autocmd BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set number

