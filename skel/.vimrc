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

if v:version >= 700
    execute pathogen#infect()
endif

au BufNewFile,BufRead *.ad set filetype=text

" Preserve screen contents when CTRL+Z'ing out of vim
set t_ti= t_te=

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %
