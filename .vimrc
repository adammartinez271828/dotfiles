set nocompatible  " be iMproved, requred
filetype off  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Lightline
Plugin 'itchyny/lightline.vim'

" Gitgutter
Plugin 'airblade/vim-gitgutter'

" Indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" Improved code folding
Plugin 'tmhedberg/SimplyFold'

" Autocompletion for Python
Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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

" Enable all Python syntax highlighting features

" Add vertical line
set colorcolumn=80

" Mark EOL whitespace as bad
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.rs match BadWhitespace /\s\+$/

" Press F9 to execute current buffer
" nnoremap <F9> :!%:p<Enter>

" Configuration for .py files
" autocmd BufNewFile *.py
"     \ 0r ~/.vim/skeleton.py

autocmd BufNewFile,BufRead *.py
    \ let python_highlight_all = 1 |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set number
