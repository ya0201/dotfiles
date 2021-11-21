#!/usr/bin/env zsh

function _install() {
  # zplug installation
  if [[ ! -f $ZPLUG_HOME/init.zsh ]]; then
    echo "Installing zplug..."
    echo; curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi

  source $ZPLUG_HOME/init.zsh
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-completions"
  zplug "rupa/z"

  # Install packages that have not been installed yet
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
  fi

  return 0
}

function _suppress() {
  touch $ZSH_PLUGINS_NO_INSTALL
}

function main() {
  source $(cd $(dirname $0);pwd)/../files/.zshenv

  local progname="$0"
  local subcmd="$1"

  usage() {
      echo "Usage: $progname [Subcommand]"
      echo
      echo "Subcommands:"
      echo "  install"
      echo "  suppress-warning"
      echo
      exit 1
  }

  [[ -z "$subcmd" ]] && usage

  case $subcmd in
      'install')
          _install
          ;;
      'suppress-warning')
          _suppress
          ;;
      -h | --help)
          usage
          exit 1
          ;;
  esac
}

main "$@"
