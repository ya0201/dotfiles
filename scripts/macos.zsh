#!/usr/bin/env zsh

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

popd
