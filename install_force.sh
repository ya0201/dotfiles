#!/bin/sh
ln -sf $(cd $(dirname $0) && pwd)/.vimrc $HOME/.vimrc
ln -sf $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
