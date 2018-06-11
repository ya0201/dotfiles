#!/bin/sh
ln -sf $(cd $(dirname $0) && pwd)/vim/.vimrc $HOME/.vimrc
ln -sf $(cd $(dirname $0) && pwd)/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/basic.vim $XDG_CONFIG_HOME/nvim/basic.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/plugs.vim $XDG_CONFIG_HOME/nvim/plugs.vim
ln -sf $(cd $(dirname $0) && pwd)/nvim/markdown.vim $XDG_CONFIG_HOME/nvim/markdown.vim
ln -sf $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
ln -sf $(cd $(dirname $0) && pwd)/.zshenv $HOME/.zshenv
