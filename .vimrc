let python_highlight_all=1
syntax on
set background=dark

" My leader is space
let mapleader = (' ')

" use the system clipboard
set clipboard=unnamed

set mouse=a

" set line numbers
set number

set nowrap

" Add the proper PEP 8 indentation
au BufNewFile,BufRead *.py,*.pyx
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" set search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Add plugins
call plug#begin('~/.vim/plugged')

" to comment blocks of code
Plug 'preservim/nerdcommenter'
vmap <leader>/ <plug>NERDCommenterToggle
nmap <leader>/ <plug>NERDCommenterToggle

" Send python code to other pane
Plug 'lotabout/slimux'
map <Leader>c :SlimuxREPLSendLine<CR>
vmap <Leader>c :SlimuxREPLSendSelection<CR>
map <Leader>b :SlimuxREPLSendBuffer<CR>
"xmap <Leader>b :SlimuxREPLConfigure
let g:slimux_select_from_current_window = 1

" Send entire function to other pane
map <Leader>F :norm V[[O]]]k 99<CR>
vmap <Leader>99 <Esc>mzgv<leader>j :SlimuxREPLSendSelection<CR>

" fuzzy finder -- :Files, :Buffers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ALE linter and fixer
Plug 'dense-analysis/ale'
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['black']}
let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'hybrid'
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

" Black formatter
Plug 'psf/black', { 'branch': 'stable' }
augroup black_on_save " running black formatter on file save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

" fold -- zo to open, zc to close
" zM to close all functions at once, zR to open all
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_fold_blank = 1
set foldmethod=indent
set foldlevel=1

" py doc strings -- just type :Pydocstring
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
let g:pydocstring_formatter = 'google'

call plug#end()
