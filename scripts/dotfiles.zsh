#!/usr/bin/env zsh

# must be work in files directory...
pushd "$(cd $(dirname $0) &>/dev/null; pwd)/../files"

DEBUG_ENABLED=${DEBUG_ENABLED:-'true'}
debug_log() {
  [[ $DEBUG_ENABLED = 'true' ]] && echo "$@" >&2
}

echo "Deploying dotfiles..."

CWD=$(pwd)
for f in ${(@f)"$(ls -a)"}; do
  [[ $f = "." ]] && continue
  [[ $f = ".." ]] && continue
  [[ $f = ".config" ]] && continue
  [[ $f = ".ssh" ]] && continue
  [[ $f = *.md ]] && continue
  [[ $f = *.sh ]] && continue
  [[ $f = *.txt ]] && continue

  if [[ -e $HOME/$f ]]; then
    echo "Cannot deploy $f: $HOME/$f already exists."
  else
    debug_log "ln -s $CWD/$f $HOME/$f"
    ln -s $CWD/$f $HOME/$f
  fi
done

pushd .config
CWD=$(pwd)
mkdir -p $HOME/.config
for f in ${(@f)"$(ls -a)"}; do
  [[ $f = "." ]] && continue
  [[ $f = ".." ]] && continue
  if [[ -e $HOME/.config/$f ]]; then
    echo "Cannot deploy $f: $HOME/.config/$f already exists."
  else
    debug_log "ln -s $CWD/$f $HOME/.config/$f"
    ln -s $CWD/$f $HOME/.config/$f
  fi
done
popd

pushd .ssh
CWD=$(pwd)
mkdir -p $HOME/.ssh
if [[ -e $HOME/.ssh/config ]]; then
  echo "Cannot deploy .ssh/config: $HOME/.ssh/config already exists."
else
  debug_log "ln -s $CWD/config $HOME/.ssh/config"
  ln -s $CWD/config $HOME/.ssh/config
fi
popd

echo "Deployment of dotfiles done."
popd
