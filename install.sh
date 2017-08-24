#!/bin/sh
ln -s $(cd $(dirname $0) && pwd)/.vimrc $HOME/.vimrc
ln -s $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
