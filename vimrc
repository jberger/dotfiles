set nocompatible | filetype indent plugin on | syn on

" bootstrap VAM
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  let c.log_to_buf = 1
  let c.auto_install = 1
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" addons
VAMActivate github:bling/vim-airline
VAMActivate github:vim-airline/vim-airline-themes
VAMActivate github:vim-perl/vim-perl
"VAMActivate github:w0rp/ale
"VAMActivate github:altercation/vim-colors-solarized
VAMActivate github:arcticicestudio/nord-vim
VAMActivate github:kien/ctrlp.vim
VAMActivate github:yko/mojo.vim
VAMActivate github:elzr/vim-json
VAMActivate github:mileszs/ack.vim
VAMActivate github:airblade/vim-gitgutter
VAMActivate github:tpope/vim-fugitive
VAMActivate github:tpope/vim-surround
VAMActivate github:scrooloose/nerdcommenter
VAMActivate github:gregsexton/MatchTag
VAMActivate github:tpope/vim-unimpaired
"VAMActivate github:majutsushi/tagbar " requires ctags executable
VAMActivate github:chrisbra/Recover.vim
VAMActivate github:bronson/vim-visual-star-search
VAMActivate github:farmergreg/vim-lastplace
"VAMActivate github:unblevable/quick-scope
VAMActivate github:AndrewRadev/splitjoin.vim
VAMActivate github:lifepillar/pgsql.vim
VAMActivate github:janko/vim-test
VAMActivate github:editorconfig/editorconfig-vim

"HTML completion, <c-y>,
VAMActivate github:mattn/emmet-vim

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
colorscheme nord

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
