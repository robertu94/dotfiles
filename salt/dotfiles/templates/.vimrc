"Vundle Set up (((
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
Plugin 'VundleVim/Vundle.vim.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/syntastic'
{% if (grains['vim_major_version']|int == 7 and grains['vim_minor_version']|int >= 4) or (grains['vim_major_version']|int >= 8) %}
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
{% endif %}
Plugin 'tpope/vim-eunuch.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'vim-scripts/scratch.vim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'IrishPrime/WhiteWash.vim'
Plugin 'vim-jp/vim-go-extra'
Plugin 'fatih/vim-go.git'
Plugin 'chase/vim-ansible-yaml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'rust-lang/rust.vim'
Plugin 'nickhutchinson/vim-systemtap'
filetype plugin indent on
" )))

"Mappings (((
inoremap jj <ESC>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <Leader> <Plug>(easymotion-prefix)
")))

" Editor Options (((
set autoindent
set backspace=indent,eol,start
set hidden
set history=200
set incsearch
set ignorecase
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
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ 12
    else
        set guifont=Ubuntu\ Mono\ derivative\ Powerline:h13
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

"Syntastic Options
let g:syntastic_cpp_compiler_options = '-std=c++11'
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
                    \if &omnifunc == "" |
                    \ setlocal omnifunc=syntaxcomplete#Complete |
                    \endif
    endif
    filetype plugin indent on

	"On some distros, the .md filetype is not treated as markdown
	"Since I never use modula2, I will overwrite it here
	autocmd BufRead *.md set ft=markdown

    augroup markdown
        autocmd FileType markdown setlocal tw=80
    augroup END

    augroup python
        autocmd FileType python setlocal expandtab
        autocmd FileType python setlocal foldmethod=indent
    augroup END

    augroup make
        autocmd FileType make setlocal foldmethod=indent
    augroup END
endif
" )))

" vim: foldmethod=marker foldmarker=(((,)))
