#!/usr/bin/env bash
set -e

[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME="$HOME/.config"

function check_is_installed() {
  which $@ >/dev/null 2>&1
}


# to install coc correctly
# see: https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim
## install node
curl -sL install-node.now.sh/lts | sudo bash

## install yarn with npm (required by neovim)
sudo npm install -g yarn

sudo apt install -y curl python3-pip zsh neovim peco tmux
sudo pip3 install neovim

check_is_installed zsh && chsh -s $(which zsh)

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

nvim -c PlugInstall -c qa

# editor config (in visudo and etc.) from nano to some config
# interactive setting
sudo update-alternatives --config editor
