#!/usr/bin/env zsh
set -euo pipefail

is_installed() {
  which "$@" &>/dev/null
}

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
mkdir -p $XDG_DATA_HOME

# add homebrew binary to PATH temporarily
## for apple sillicon macos
export PATH="$PATH:/opt/homebrew/bin"
