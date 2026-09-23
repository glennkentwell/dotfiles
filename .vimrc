
set tabstop=2			" for 1 tab
set shiftwidth=2	" auto-indents
set softtabstop=2	" idk confusing

" smartindent is deprecated
" set smartindent
filetype plugin indent on

" set noexpandtab	" i had this set but it's wrong?
set expandtab			" replace tabs with spaces
set number				" show line numbers
set nowrap				" don't wrap it, postpak it

syntax on					" hiliten

" don't leave shit all over the place
execute 'silent ! mkdir -p ~/.vim/backup ~/.vim/swap'
set directory=$HOME/.vim/swap
set backupdir=$HOME/.vim/backup

set rtp+=/opt/homebrew/opt/fzf


let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
