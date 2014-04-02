set nocompatible

" addons
set runtimepath+=~/.vim/vim-addon-manager
call vam#ActivateAddons(['github:vim-perl/vim-perl'])
call vam#ActivateAddons(['github:altercation/vim-colors-solarized'])
call vam#ActivateAddons(['github:kien/ctrlp.vim'])
call vam#ActivateAddons(['github:yko/mojo.vim'])
call vam#ActivateAddons(['github:mileszs/ack.vim'])

" mojo (doesn't seem to be working for me)
let mojo_highlight_data=1

" behavior
syntax enable
set modelines=0
set encoding=utf-8
filetype plugin indent on
set number
set hidden
set title
set scrolloff=3
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set ruler
set ttyfast
set backspace=indent,eol,start
set colorcolumn=90

" tabbing
set autoindent            " auto-indent
set tabstop=2             " tab spacing
set softtabstop=2         " unify
set shiftwidth=2          " indent/outdent by 2 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs

" search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" perltidy
nnoremap <Leader>t mz:%!perltidy -q<CR>'z:delmarks z<CR>

" invisible characters
"set list
"set listchars=tab:▸\ ,eol:¬

" theme
set background=dark
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" see also:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

