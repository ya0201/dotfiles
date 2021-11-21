" load basic config
if filereadable($XDG_CONFIG_HOME . '/nvim/basic.vim')
  source $XDG_CONFIG_HOME/nvim/basic.vim
else
  echo "Not found: $XDG_CONFIG_HOME/nvim/basic.vim"
endif

filetype plugin indent on
