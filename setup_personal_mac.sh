#!/bin/bash

set -e
# install brew

# initialize
brew bundle --file=.Brewfile_working
brew bundle --file=.Brewfile_personal

# deploy dotfiles
git clone https://github.com/ya0201/dotfiles
cd dotfiles
source deploy_dotfiles.sh

# nvim setting
pip3 install neovim
vim -c PlugInstall -c qa

