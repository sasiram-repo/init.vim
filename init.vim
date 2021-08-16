" Plugin Section
call plug#begin("~/.vim/plugged")
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'preservim/nerdtree'               "file explorer
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/popup.nvim'              "needed for fuzzy file search
Plug 'nvim-lua/plenary.nvim'            "needed for fuzzy file search
Plug 'nvim-telescope/telescope.nvim'    "fuzzy file search
Plug 'sheerun/vim-polyglot'
"Plug 'rafamadriz/friendly-snippets
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

"This is needed for nord theme to work properly in WSL terminal window
if (has("termguicolors"))
    set termguicolors
end


"""custom settings"""
set number relativenumber
set clipboard+=unnamedplus
set ignorecase
set smartindent
set expandtab

set cursorline
set title

set mouse=a
set cmdheight=2
set scrolloff=2

set hidden
set switchbuf=usetab

" open new split panes to right and below
set splitright
set splitbelow

filetype on
filetype plugin on
filetype indent on

syntax enable
colorscheme dracula

""" Plugins setup and configs """

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NERDTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules']
let g:NERDTreeStatusline = ''

" nvim compe auto complete settings
set completeopt =menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:true
let g:compe.source.treesitter = v:true
let g:compe.source.omni = v:true


" Setting up fuzzy file search, exluced node_modules folder
lua << EOF
require'telescope'.setup{
defaults={ file_ignore_patterns = { "node_modules", "_build", "deps" } }
}
EOF

""" Setup language servers """
" on_attach = on_attach_common
" pyright -> python
" elixirls -> elixir
lua <<EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.elixirls.setup{
    cmd = { "/home/sasi/Data/app/elixir-ls/language_server.sh" }
}
EOF

""" map leader key as spacebar """
nnoremap <SPACE> <Nop>
let mapleader = " "


if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"""File search shortcuts"""
nnoremap <silent> <leader>ff :Telescope find_files<cr>
nnoremap <silent> <leader>fg :Telescope live_grep<cr>
nnoremap <silent> <leader>fb :Telescope buffers<cr>
nnoremap <silent> <leader>fh :Telescope help_tags<cr>

"""NERDTree shortcuts"""
nnoremap <silent> <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nf :NERDTreeFocus<cr>

"""NERDCommenter shortcuts"""
"Do not use any mapping that is starting with <leader>c
"because they are the default mappings of NERD commenter

"""Terminal shortcuts"""
nnoremap <silent> <leader>tt :split \| term<cr><i>
nnoremap <silent> <leader>tv :vsplit \| term<cr><i>
tnoremap <Esc> <C-\><C-n> "Use escape to switch to normal mode

"""Buffer shortcuts"""
nnoremap <silent> <A-2> :bn<cr>
nnoremap <silent> <A-1> :bp<cr>
nnoremap <silent> <C-s> :w<cr>
nnoremap <silent> <A-c> :close<cr>
nnoremap <A-b> :b<space>

"""Navigation shortcuts"""
"Normal mode
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-h> <C-w><C-h>
nnoremap <A-l> <C-w><C-l>

"Terminal mode shortcuts
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-2> <C-\><C-n>:bn<CR>
tnoremap <A-1> <C-\><C-n>:bp<CR>

"Auto complete shortcuts for nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"""Window sizing shortcuts"""
nnoremap <silent> <C-Up> :resize +2<cr>
nnoremap <silent> <C-Down> :resize -2<cr>
nnoremap <silent> <C-Left> :vertical resize -2<cr>
nnoremap <silent> <C-Right> :vertical resize +2<cr>

inoremap jj <Esc>