#!/usr/bin/env zsh
set -e

# must be work in files directory...
pushd "$(cd $(dirname $0) &>/dev/null; pwd)/../files"

stow -v -t ${HOME} home

mkdir -p ${HOME}/.config
stow -v -t ${HOME}/.config .config

mkdir -p ${HOME}/.ssh
stow -v -t ${HOME}/.ssh .ssh

dst="${HOME}/Library/Application Support/Code/User"
mkdir -p ${dst}
stow -v --ignore=extensions -t ${dst} vscode

popd

set +e
