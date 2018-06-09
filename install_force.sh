#!/bin/sh
ln -sf $(cd $(dirname $0) && pwd)/.vimrc $HOME/.vimrc
ln -sf $(cd $(dirname $0) && pwd)/.vimrc_md $HOME/.vimrc_md
ln -sf $(cd $(dirname $0) && pwd)/.zshrc $HOME/.zshrc
ln -sf $(cd $(dirname $0) && pwd)/.zshenv $HOME/.zshenv
