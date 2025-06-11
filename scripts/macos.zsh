#!/usr/bin/env zsh
set -euo pipefail

# must be work in project root...
pushd "$(cd $(dirname $0) &>/dev/null; pwd)/.."

# initialize
source ./scripts/common-initialization.zsh

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
echo "Deployment of dotfiles done."
echo ''

echo 'Installing neovim package for python3 and vim plugins...'
pip3 install --user pynvim
nvim -c PlugInstall -c qa
echo 'Done.'
echo ''

mkdir -p ~/GoogleDrive

# git config
git config --global push.autoSetupRemote true

popd
