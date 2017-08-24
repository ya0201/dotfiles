set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set cursorline
syntax on


let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if !filereadable(expand('~/.vim/vim-plug/plug.vim'))
  call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')

  Plug 'scrooloose/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'open-browser.vim'
  Plug 'mattn/webapi-vim'
  Plug 'tell-k/vim-browsereload-mac'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'taichouchou2/html5.vim'
  Plug 'kchmck/vim-coffee-script'

call plug#end()
