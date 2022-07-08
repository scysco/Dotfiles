filetype plugin indent on
set clipboard=unnamedplus 
set cursorline
set mouse=a
set number relativenumber
set noshowmode
set laststatus=2
set showcmd
set showmatch
set sw=2
set ts=2
map <C-y> :w !xclip -sel c <CR><CR>

syntax on

"so ~/.vim/plugins.vim

call plug#begin()
Plug 'sheerun/vim-polyglot'

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'mhinz/vim-signify', { 'branch': 'legacy' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

colorscheme gruvbox
set bg=dark
let g:gruvbox_contrast_dark = "hard"
highlight Normal     ctermbg=NONE guibg=NONE
"highlight LineNr     ctermbg=NONE guibg=NONE
"highlight SignColumn ctermbg=NONE guibg=NONE

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
