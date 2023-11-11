#!/usr/bin/env zsh

source "$(cd $(dirname $0) &>/dev/null; pwd)/../files/.zshenv"

# zplug installation
if [[ ! -f $ZPLUG_HOME/init.zsh ]]; then
  echo "Installing zplug..."
  echo; curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
  source $ZPLUG_HOME/init.zsh
else
  echo 'Error: Could not install zplug correctly.'
  exit 1
fi
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "rupa/z"

# Install packages that have not been installed yet
if ! zplug check; then
  zplug install
fi
