set nocompatible | filetype indent plugin on | syn on

" --- vim-plug: bootstrap itself on first launch, then auto-install plugins ---
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-perl/vim-perl'
" Plug 'dense-analysis/ale'                  " (was w0rp/ale; renamed)
" Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'ctrlpvim/ctrlp.vim'                    " maintained fork of kien/ctrlp.vim
Plug 'yko/mojo.vim'
Plug 'elzr/vim-json'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'              " was scrooloose/nerdcommenter
Plug 'gregsexton/MatchTag'
Plug 'tpope/vim-unimpaired'
" Plug 'preservim/tagbar'                    " was majutsushi/tagbar; requires ctags
Plug 'chrisbra/Recover.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'farmergreg/vim-lastplace'
" Plug 'unblevable/quick-scope'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'janko/vim-test'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'                       " HTML completion, <c-y>,
Plug 'HerringtonDarkholme/yats.vim'         " TypeScript syntax (replaces vim's runtime TS syntax)

call plug#end()

augroup TypeScriptRegexFix
  autocmd!
  " Force the more robust engine locally only for TypeScript and TSX files
  autocmd FileType typescript,typescriptreact setlocal regexpengine=2
augroup END

" swap, backup, undo file sanity
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p", 0700)
endif
if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p", 0700)
endif
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
endif
set directory^=$HOME/.vim/swap//
set backupdir^=$HOME/.vim/backup//
set undodir^=$HOME/.vim/undo//

" theme
set background=dark
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
"colorscheme solarized
silent! colorscheme nord " silent! so the first (pre-install) launch doesn't error

" perl
let perl_sub_signatures = 1
let perl_extended_vars = 1
let perl_include_pod = 1

" postgres
let g:sql_type_default = 'pgsql' " default sql files to postgres syntax

" syntax checking (ale)
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -It/lib -Ilocal/lib/perl5'
" I'm not a fan of perl-critic
let g:ale_linters = {'perl': ['perl'],}
" prevent the linter from running while typing
let g:ale_lint_on_text_changed = 'never'

" mojolicious
"let mojo_highlight_data=1

" javascript modules
au BufRead,BufNewFile *.mjs setfiletype javascript

" json
let g:vim_json_syntax_conceal = 0

" behavior
syntax enable
set modelines=0
set encoding=utf-8
set number
set hidden
set title
set scrolloff=3
set showmode " disabled by airline below
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set ruler
set ttyfast
set backspace=indent,eol,start
set colorcolumn=90
set nojoinspaces " don't join sentances with double space
set mmp=10000

" spell checking
set spelllang=en_us
nnoremap <Leader>s :setlocal spell!<cr>
" reminder use:
"   [s and ]s to skip to spelling problems
"   z= to get suggestions
"   zg to add to dictionary
"   zw to mark as incorrect

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

" vim shortcuts
" cleanup whitespace
nnoremap <Leader>we :%s/\s\+$//<CR>
nnoremap <Leader>wt :retab<CR>
nnoremap <Leader>wa :retab \| :%s/\s\+$//<CR>
" insert a literal tab with shift-tab
inoremap <S-Tab> <C-V><Tab>
" see listing (non-printable characters)
nnoremap <Leader>l :set list!<CR>

" vim-test
let test#perl#prove#options = '-I local/lib/perl5'
let test#perl#prove#file_pattern = '.*\.t$'
let test#javascript#mocha#file_pattern = '\vtests?/.*\.(js|mjs|jsx|coffee)$'
nnoremap <Leader>p <Esc>:TestFile<CR>

" external commands:
" perltidy
nnoremap <Leader>t mz:%!perltidy -q<CR>'z:delmarks z<CR>

" invisible characters
"set list
"set listchars=tab:▸\ ,eol:¬

" ctags integration (from http://andrew.stwrt.ca/posts/vim-ctags/):
" ctrlp
nnoremap <leader>. :CtrlPTag<cr>
" tagbar
nnoremap <silent> <Leader>b :TagbarOpenAutoClose<CR>
nnoremap <silent> <Leader>B :TagbarToggle<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|(vendor)|(node_modules))$',
  \ 'file': '\v\.(exe|so|dll)$',
\ }

" airline
set ttimeoutlen=50
set laststatus=2
set noshowmode

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_left_sep = '' " '▶'
let g:airline_right_sep = '' " '◀'
let g:airline_symbols.linenr = '' " '␊'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" airline tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" see also:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
" http://grantlucas.com/posts/2012/09/using-vim-arduino-development
