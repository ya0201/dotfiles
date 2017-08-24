set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set cursorline
set paste
set backspace=indent,eol,start
syntax on
filetype on

nnoremap <silent><C-x> :NERDTreeToggle<CR>
let NERDTreeWinSize=23

" Nerd_Commenter の基本設定
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDDefaultAlign='left'
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle

let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if !filereadable(expand('~/.vim/vim-plug/plug.vim'))
  call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')

  Plug 'scrooloose/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'scrooloose/nerdcommenter'

call plug#end()
