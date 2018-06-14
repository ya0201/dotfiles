#!/bin/sh

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
  if [ ! -e $XDG_CONFIG_HOME ]; then
    mkdir $XDG_CONFIG_HOME
  fi
fi
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
  if [ ! -e $HOME/.local ]; then
    mkdir $HOME/.local
  fi
  if [ ! -e $XDG_DATA_HOME ]; then
    mkdir $XDG_DATA_HOME
  fi
fi

if [ ! -e $XDG_CONFIG_HOME/nvim ]; then
  mkdir $XDG_CONFIG_HOME/nvim
fi

ln -s $(cd $(dirname $0) && pwd)/vim/.vimrc $HOME/.vimrc
ln -s $(cd $(dirname $0) && pwd)/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -s $(cd $(dirname $0) && pwd)/nvim/basic.vim $XDG_CONFIG_HOME/nvim/basic.vim
ln -s $(cd $(dirname $0) && pwd)/nvim/plugs.vim $XDG_CONFIG_HOME/nvim/plugs.vim
ln -s $(cd $(dirname $0) && pwd)/nvim/markdown.vim $XDG_CONFIG_HOME/nvim/markdown.vim
ln -s $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
ln -s $(cd $(dirname $0) && pwd)/.zshenv $HOME/.zshenv
