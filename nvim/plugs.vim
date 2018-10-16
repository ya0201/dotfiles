" assumed to be loaded by basic.vim

" directory config for vim/nvim
if has('nvim')
  let s:vim_plug_dir=expand($XDG_DATA_HOME . '/nvim/vim-plug/')
  let s:plugged_dir=expand($XDG_DATA_HOME . '/nvim/plugged/')
else
  let s:vim_plug_dir=expand($HOME . '/.vim/vim-plug/')
  let s:plugged_dir=expand($HOME . '/.vim/plugged/')
endif

" VimPlug
let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if !filereadable(s:vim_plug_dir . "plug.vim")
  call system("git clone " . s:vim_plug_url . " " . s:vim_plug_dir)
endif
execute "source " . s:vim_plug_dir . "plug.vim"

" load plugins
call plug#begin(s:plugged_dir)
  Plug 'cocopon/iceberg.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'scrooloose/nerdcommenter'
  Plug 'stephpy/vim-yaml'
  Plug 'godlygeek/tabular', {'for': 'markdown'} | Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
  Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
  " Plug 'justmao945/vim-clang', {'for': 'cpp'}
  Plug 'cespare/vim-toml', {'for': 'toml'}
  Plug 'thinca/vim-quickrun'
  Plug 'ya0201/vim-exesound'
  " Plug 'Shougo/neosnippet'
  " Plug 'Shougo/neosnippet-snippets'

  " if has('nvim')
  "   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " else
  "   Plug 'Shougo/deoplete.nvim'
  "   Plug 'roxma/nvim-yarp'
  "   Plug 'roxma/vim-hug-neovim-rpc'
  " endif

  " A dependency of 'ncm2'.
	Plug 'roxma/nvim-yarp'
  " v2 of the nvim-completion-manager.
	Plug 'ncm2/ncm2'
  " snippet
  Plug 'SirVer/ultisnips'
  Plug 'ncm2/ncm2-ultisnips'

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()


" NERDTree
nnoremap <silent><C-x> :NERDTreeToggle<CR>
let NERDTreeWinSize=23
augroup nerdtree_autoclose
  autocmd!
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Nerd_Commenter
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDDefaultAlign='left'
nmap \\ <Plug>NERDCommenterToggle
vmap \\ <Plug>NERDCommenterToggle

" Vim Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_conceal = 0

" QuickRun
nnoremap qr :QuickRun -mode n<CR>
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
  \  },
  \}

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-\>     <Plug>(neosnippet_expand_or_jump)
" smap <C-\>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-\>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" vim-exesound
let g:exesound_auto_nt_open = 1
let g:exesound_auto_focus_on_nt = 1
let g:exesound_py_version = 3

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {}
if executable('cquery')
  let g:LanguageClient_serverCommands = {
    \ 'c': ['/usr/local/bin/cquery', 
    \ '--log-file=/tmp/cq.log', 
    \ '--init={"cacheDirectory":"/var/cache/cquery/"}'],
    \ 'cpp': ['/usr/local/bin/cquery', 
    \ '--log-file=/tmp/cq.log', 
    \ '--init={"cacheDirectory":"/var/cache/cquery/"}']
    \ }
endif
augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted setlocal signcolumn=yes
  autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = "Location"
command! -nargs=0 Langhover call LanguageClient_textDocument_hover()
command! -nargs=0 Langdef call LanguageClient_textDocument_definition()
command! -nargs=0 Langrename call LanguageClient_textDocument_rename()
command! -nargs=0 Langformat call LanguageClient_textDocument_formatting()
nnoremap <C-]> :Langdef<CR>
" call deoplete#custom#source('LanguageClient',
"   \ 'min_pattern_length',
"   \ 2)

" deoplete options
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 0
" let g:deoplete#auto_complete_start_length = 1
" let g:deoplete#enable_camel_case = 0
" let g:deoplete#enable_ignore_case = 0
" let g:deoplete#enable_refresh_always = 0
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#file#enable_buffer_path = 1
" let g:deoplete#max_list = 10000
" let g:deoplete#sources = {}
" let g:deoplete#sources.cpp = ['LanguageClient']

" ncm2
augroup ncm2_rc
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END
set completeopt=noinsert,menuone,noselect
" settings to disable auto_popup (can be harmful) and manual popup key
" let g:ncm2#auto_popup = 0
" imap <silent><expr> <C-\> "\<Plug>(ncm2_manual_trigger)"
" When the arrow key (up or down) is pressed while the popup menu is visible, 
" map it to <c-p> or <c-n>.
inoremap <expr> <Up> (pumvisible() ? "\<c-p>" : "\<Up>")
inoremap <expr> <Down> (pumvisible() ? "\<c-n>" : "\<Down>")

" ncm2-ultisnip
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger    = "<Plug>(ultisnips_expand)"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME.'/myultisnips']
