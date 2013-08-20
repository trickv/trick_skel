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

" turn on mouse support
set mouse=a

" show whitespace at end of lines    
" 2010-07-22: this makes me too angry sometimes. should be ft specific.
"set list listchars=trail:.

" Don't allow vim to use dos filetype.  Make those ugly ^M's stand out!
set fileformats=unix

autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \     exe "normal g'\"" |
      \ endif | 

execute pathogen#infect()

au BufNewFile,BufRead *.ad set filetype=text
