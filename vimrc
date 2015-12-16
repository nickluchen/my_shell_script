syntax on

set nu
set hlsearch

" Make the color of the comments more readable.
set background=dark

set tabstop=4
set shiftwidth=4

"set expandtab
"set cindent

" Highlight the column 81.
" Please note this feature is introduced in VIM 7.3.
set colorcolumn=81
hi ColorColumn ctermbg=lightgrey

" Mapping the file with given extension to specified syntax.
au BufNewFile,BufRead *.mb set filetype=sh
au BufNewFile,BufRead *.p2_plugin set filetype=python

""""" settings for gvim(vim-gtk, vim-gnome) under Linux """""
"set guifont=Consolas\ 10

""""" Font settings for MacVim """""
"set gfn=Consolas:h13
