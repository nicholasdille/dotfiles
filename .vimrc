" sanity for sourcing
set nocompatible

" file types and indenting
filetype indent plugin on
" enable syntax highlighting
syntax on
" retain indentation
set autoindent
" configure indentation to 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType Makefile setlocal noexpandtab

" enable reading configuration from source file
set modeline
set modelines=5

" enable re-using windows and saving buffers for multiple files
set hidden

" improve command line completion
set wildmenu

" show partial commands
set showcmd

" highlight searches
set hlsearch
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>

" improve case-sensitivity when searching
set ignorecase
set smartcase

" improve backspace behaviour
set backspace=indent,eol,start

" stop certain movements from always going to the first character of a line
set nostartofline

" show cursor position
set ruler

" always show status bar
"set laststatus=2

" visual bell instead of beep
set visualbell
" reset visual bell code
set t_vb=

" enable mouse
"set mouse=a

" load pathogen package manager
" loads any module under ~/.vim/bundle/
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" load theme theme
let g:airline_theme='jellybeans'
"colorscheme jellybeans
