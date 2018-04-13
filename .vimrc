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

" load settings for markdown file
autocmd FileType markdown source <sfile>:h/.vimrc_md

" VimPlug
let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if !filereadable(expand('~/.vim/vim-plug/plug.vim'))
  call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'scrooloose/nerdcommenter'
  Plug 'stephpy/vim-yaml'
  Plug 'godlygeek/tabular', {'for': 'markdown'} | Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
  Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
  Plug 'justmao945/vim-clang', {'for': 'cpp'}
  Plug 'thinca/vim-quickrun'
  Plug 'Shougo/neocomplete'
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
call plug#end()


" NERDTree
nnoremap <silent><C-x> :NERDTreeToggle<CR>
let NERDTreeWinSize=23

" Nerd_Commenter
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDDefaultAlign='left'
nmap \\ <Plug>NERDCommenterToggle
vmap \\ <Plug>NERDCommenterToggle

" Vim Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

" QuickRun
nnoremap <silent><Space>r :QuickRun -mode n<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
command! Q echo "No such command. Which do you mean :QuickRun or :q?"
au FileType qf nnoremap <silent><buffer>q :quit<CR>
let g:quickrun_config = {
      \'_' : {
      \   'outputter/buffer/split' : ':botright 8sp',
      \   'outputter/error/success' : 'buffer',
      \   'outputter/error/error'   : 'quickfix',
      \   "outputter/buffer/into" : '1',
      \   'outputter/quickfix/errorformat' : '%f:%l,%m in %f on line %l',
      \   'outputter/buffer/close_on_empty' : 1,
      \   'outputter' : 'error',
      \},
      \}

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
