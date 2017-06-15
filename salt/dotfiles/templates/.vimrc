"Vundle Set up (((
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'

"Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

"Features
Plugin 'IrishPrime/WhiteWash.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rkitover/vimpager.git'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'qpkorr/vim-bufkill.git'
Plugin 'vim-scripts/dbext.vim'
Plugin 'vim-scripts/scratch.vim'

"Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'matthewsimo/angular-vim-snippets'


"Interface
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'

"Language Plugins
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'chase/vim-ansible-yaml'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'fatih/vim-go'
Plugin 'nickhutchinson/vim-systemtap'
Plugin 'rodjek/vim-puppet'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-jp/vim-go-extra'
Plugin 'davidhalter/jedi-vim'
Plugin 'esorton/vim-aadl'

"Web Related plugins
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'burnettk/vim-angular'
Plugin 'claco/jasmine.vim'


{% if nvim %}
"NVIM
Plugin 'critiqjo/lldb.nvim'
Plugin 'vim-utils/vim-man'
{% endif %}


filetype plugin indent on
" )))

"Mappings (((
inoremap jj <ESC>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <Leader> <Plug>(easymotion-prefix)
{% if llvm_path %}
autocmd FileType cpp nmap gq :pyf {{ llvm_path ~ "clang-format.py<CR>" }}
autocmd FileType cpp nmap <leader>if :pyf {{ llvm_path ~ "clang-include-fixer.py<CR>" }}
autocmd FileType cpp nmap <leader>cr :pyf {{ llvm_path ~ "clang-rename.py<CR>" }}

function FormatFile()
  let l:lines="all"
  pyf {{ llvm_path ~ "clang-format.py" }}
endfunction
{% endif %}
")))

" Editor Options (((
set autoindent
set backspace=indent,eol,start
set hidden
set history=200
set incsearch
set ignorecase
set matchpairs+=<:>
set mouse=a
set number
set shiftwidth=4
set smartcase
set softtabstop=4
set spell spelllang=en_us
set tabstop=4
set nowrap
set wildignore+=*.git/*,*.hg/*,*.svn/*,*/__pycache__/*
set wildmode=longest:full,full
set wildmenu
syntax on
")))

" Interface Options (((
set background=dark
set encoding=utf-8
set laststatus=2
set splitright
set t_Co=256
silent! colorscheme solarized

if has("gui_running")
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=L
	if has("gui_gtk")
		set guifont=Terminess\ Powerline\ 10
	elseif has("gui_win32")
		set guifont=Courier_New:h8:cANSI
	endif
endif
" )))

"Plugins Options (((

"Airline Options 
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'solarized'

"CTRL P Options
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir']
"
"NerdTree Options
let NERDTreeIgnore=['.pyc$']


"Ultisnips
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"Syntastic Options
let g:syntastic_cpp_compiler_options = '-std=c++14 -I/usr/include/SDL2 -I /usr/include/qt5/QtCore'
let g:syntastic_python_python_exec = '/bin/python3'
let g:syntastic_python_checkers = [ 'pylint', 'python3' ]

"Tagbar Options
nnoremap <silent> <F9> :TagbarToggle<CR>

"Vimpager Options
let vimpager_disable_ansiesc = 1

" )))

"Lanuage Specific Options (((
set foldmethod=syntax
if has("autocmd")
    if exists("+omnifunc")
        autocmd Filetype *
                    \ if &omnifunc == "" |
                    \ setlocal omnifunc=syntaxcomplete#Complete |
                    \ endif
    endif

	"On some distros, the .md filetype is not treated as markdown
	"Since I never use modula2, I will overwrite it here
	autocmd BufRead *.md set ft=markdown

    augroup python
        autocmd FileType python setlocal expandtab foldmethod=indent
    augroup END

    augroup make
        autocmd FileType make setlocal foldmethod=indent
    augroup END
endif
" )))

" vim: foldmethod=marker foldmarker=(((,)))
