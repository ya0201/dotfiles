#!/usr/bin/env zsh
set -euo pipefail

is_installed() {
  which "$@" &>/dev/null
}

# must be work in project root...
pushd "$(cd $(dirname $0) &>/dev/null; pwd)/.."

# load env vars
source ./files/home/.zshenv

echo 'hello, macos!'
echo 'Installing Homebrew...'
if is_installed 'brew'; then
  echo 'Homebrew already installed.'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! is_installed 'brew'; then
  echo 'Could not install Homebrew.' >&2
  exit 1
fi

echo 'Install some packages with Homebrew...'
brew bundle --file ./brew/Brewfile
echo 'Done.'
echo ''

echo 'Deploying dotfiles...'
./scripts/dotfiles.zsh
echo 'Done.'
echo ''

echo "HOME: $HOME"
echo "XDG_CONFIG_HOME: $XDG_CONFIG_HOME"

echo 'Installing neovim package for python3 and vim plugins...'
pip3 install pynvim --user --break-system-packages
nvim -c PlugInstall -c qa
echo 'Done.'
echo ''

mkdir -p ~/GoogleDrive

./scripts/common-installation.zsh

popd
