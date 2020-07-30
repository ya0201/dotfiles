#!/usr/bin/env zsh
set -e

[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME="$HOME/.config"
mkdir -p $XDG_CONFIG_HOME

function check_is_installed() {
  which $@ >/dev/null 2>&1
}

sudo yum install -y python3 python3-pip tmux git

# install fuse to run appimage
sudo yum install -y epel-release
sudo yum --enablerepo=epel -y install fuse-sshfs

# to install coc correctly
# see: https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim
## install node
curl -sL install-node.now.sh/lts | sudo bash

## install yarn with npm (required by neovim)
sudo npm install -g yarn

# install neovim and its python client
wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
chmod u+x nvim.appimage
mkdir -p ~/.local/bin
mv nvim.appimage ~/.local/bin/nvim
# sudo yum install -y python3-neovim --enablerepo=epel
sudo pip3 install neovim

# install peco
wget https://github.com/peco/peco/releases/download/v0.5.7/peco_linux_amd64.tar.gz
tar xvf peco_linux_amd64.tar.gz
mv peco_linux_amd64/peco ~/.local/bin
rm -rf peco_linux_amd64*

# install plugins on nvim
# この時点でdotfilesをcloneしていないためpluginstallはできなさそう
# ~/.local/bin/nvim -c PlugInstall

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

set +e
