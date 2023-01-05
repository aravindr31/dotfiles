set termguicolors
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=5
set relativenumber
set signcolumn=yes
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=999
set noshowmode
set updatetime=250 
set encoding=UTF-8
set mouse=a


call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'vim-airline/vim-airline' " Status bar
Plug 'neovim/nvim-lspconfig' "neovim lsp
Plug 'mbbill/undotree' " undotree
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } " Color scheme
Plug 'preservim/nerdtree' "Nerd Tree
Plug 'ctrlpvim/ctrlp.vim' "CtrlP
Plug 'preservim/nerdcommenter' "commenter
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'

call plug#end()

lua require('davidb')

" inoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>
" nnoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>

"custom keybinds
nmap <C-z> :UndotreeToggle<CR>
nmap <C-b> :NERDTreeToggle<CR>
nmap <C-p> :CtrlP<CR>

vmap // <plug>NERDCommenterToggle
nmap // <plug>NERDCommenterToggle
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


"inoremap <c-/> ++<cr>
"nnoremap <c-/> ++<cr>

" background and colorscheme

set background=dark
colorscheme gruvbox









