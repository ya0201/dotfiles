#!/bin/sh
ln -sf $(cd $(dirname $0) && pwd)/vim/.vimrc $HOME/.vimrc
ln -sf $(cd $(dirname $0) && pwd)/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/basic.vim $XDG_CONFIG_HOME/nvim/basic.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/myplugs.vim $XDG_CONFIG_HOME/nvim/myplugs.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/mymarkdown.vim $XDG_CONFIG_HOME/nvim/mymarkdown.vim
ln -sf $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
ln -sf $(cd $(dirname $0) && pwd)/.zshenv $HOME/.zshenv
