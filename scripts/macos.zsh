#!/usr/bin/env zsh
set -euo pipefail

is_installed() {
  which "$@" &>/dev/null
}

# must be work in project root...
pushd "$(cd $(dirname $0) &>/dev/null; pwd)/.."

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

echo 'Installing neovim package for python3 and vim plugins...'
pip3 install neovim --user
nvim -c PlugInstall -c qa
echo 'Done.'
echo ''

echo 'Installing some vscode extensions...'
cat ./files/vscode/extensions| xargs -I{} code --install-extension {}
echo 'Done.'
echo ''

mkdir -p ~/GoogleDrive

popd
