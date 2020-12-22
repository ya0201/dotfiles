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
  Plug 'cespare/vim-toml', {'for': 'toml'}
  Plug 'thinca/vim-quickrun'
  Plug 'ya0201/vim-exesound'
  Plug 'rust-lang/rust.vim'
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " snippet
  " Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'ctrlpvim/ctrlp.vim'
  Plug 't9md/vim-textmanip'
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
nnoremap <C-q> :<C-u>bw! \[quickrun\ output\]<CR>
command! Q echo "No such command. Which do you mean :QuickRun or :q?"
au FileType qf nnoremap <silent><buffer>q :quit<CR>
let g:quickrun_config = {
\ '_': {
\  'outputter/buffer/split' : ':botright 8sp',
\  'outputter/error/success' : 'buffer',
\  'outputter/error/error'   : 'quickfix',
\  'outputter/quickfix/errorformat' : '%f:%l,%m in %f on line %l',
\  'outputter/buffer/close_on_empty' : 1,
\  'outputter' : 'error',
\  'runner' : 'vimproc',
\  'runner/vimproc/updatetime' : 60,
\ },
\ 'tex': {
\  'command': 'latexmk',
\  'outputter/error/success' : 'null',
\  'exec': '%c',
\ },
\ 'mylatexmk': {
\  'command': 'latexmk',
\  'exec': '%c %s:r; open -ga Skim %s:r.pdf',
\ },
\ 'mylatexmkc': {
\  'command': 'latexmk',
\  'outputter/error/success' : 'null',
\  'exec': '%c -c %s:r',
\  'runner' : 'system',
\ },
\}
function! s:mylatexmk()
  if getcwd() == expand("%:p:h")
    " echo 'mylatexmk'
    QuickRun mylatexmk
  endif
endfunction
function! s:mylatexmkc()
  if getcwd() == expand("%:p:h")
    " echo 'mylatexmkc'
    QuickRun mylatexmkc
  endif
endfunction
augroup quickrun_tex
  autocmd!
  autocmd BufWritePost *.tex :call s:mylatexmk()
  autocmd BufWinLeave *.tex :call s:mylatexmkc()
augroup END

" vim-exesound
let g:exesound_auto_nt_open = 1
let g:exesound_auto_focus_on_nt = 1
let g:exesound_py_version = 3

" LanguageClient-neovim
" if executable('cquery')
"   let b:cq_cache_path = expand($XDG_CACHE_HOME . '/cquery')
"   if !isdirectory(b:cq_cache_path)
"     call mkdir(b:cq_cache_path, 'p')
"   endif
"   let g:LanguageClient_serverCommands['c'] = [
"     \ 'cquery', 
"     \ '--log-file=/tmp/cq.log', 
"     \ '--init={"cacheDirectory":"' . b:cq_cache_path . '"}']
"   let g:LanguageClient_serverCommands['cpp'] = [
"     \ 'cquery', 
"     \ '--log-file=/tmp/cq.log', 
"     \ '--init={"cacheDirectory":"' . b:cq_cache_path . '"}']
" endif
" if executable('rls')
"   let g:LanguageClient_serverCommands['rust'] = ['rls'] 
" endif
" if executable('pyls')
"   let g:LanguageClient_serverCommands['python'] = ['pyls'] 
" endif
" if executable('gopls')
"   let g:LanguageClient_serverCommands['go'] = ['gopls']
" endif
" if executable('yaml-language-server')
"   let g:LanguageClient_serverCommands['yaml'] = ['yaml-language-server', '--stdio']
" endif
" nnoremap <C-]> :Langdef<CR>


" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger    = "<Plug>(ultisnips_expand)"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME.'/myultisnips', $XDG_DATA_HOME.'/nvim/plugged/vim-snippets/UltiSnips']

" rust.vim
let g:rustfmt_autosave = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" vim-textmanip
" https://github.com/t9md/vim-textmanip
" 選択したテキストの移動
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
" 行の複製
vmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
