" set option
set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set cursorline
set backspace=indent,eol,start
syntax on
filetype on
set hlsearch
set ruler
set title
set wildmenu wildmode=list:full

if &compatible
  set nocompatible
endif

" key mapping
noremap <S-h>   ^
noremap <S-l>   $
nnoremap x "_x
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" filetype settings
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.slide set filetype=markdown
autocmd BufRead,BufNewFile *.toml set filetype=toml

" load settings for markdown file
autocmd FileType markdown source <sfile>:h/mymarkdown.vim

" load plugin config
source <sfile>:h/myplugs.vim
