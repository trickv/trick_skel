" trick_skel vimrc
" $Id$

set number
set nocompatible
set backspace=2
syntax on

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hlsearch

set smartindent

set bg=dark

autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \     exe "normal g'\"" |
      \ endif | 
