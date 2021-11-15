#!/usr/bin/env zsh

set -e
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# initialize
brew bundle --file=.brewfile_working
brew bundle --file=.brewfile_personal

# deploy dotfiles
# git clone https://github.com/ya0201/dotfiles
# cd dotfiles
./deploy_dotfiles.bash

# nvim setting
pip3 install neovim --user
vim -c PlugInstall -c qa

# dir for google drive
mkdir ~/GoogleDrive
