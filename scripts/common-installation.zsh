#!/usr/bin/env zsh
set -euo pipefail

# install asdf
[[ ! -f ${HOME}/.asdf/asdf.sh ]] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
