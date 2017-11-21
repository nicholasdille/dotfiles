" vundle {{{1

" needed to run vundle (but i want this anyways)
set nocompatible

" vundle needs filtype plugins off
" i turn it on later
filetype plugin indent off
syntax off

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" now (after vundle finished) it is save to turn filetype plugins on
filetype plugin indent on
syntax on
