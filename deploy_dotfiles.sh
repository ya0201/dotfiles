#!/usr/bin/env zsh

echo "Deploying dotfiles ..."

CWD=$(pwd)
for f in * .*; do
  [ "$f" = "." ] && continue
  [ "$f" = ".." ] && continue
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".config" ] && continue
  [ "$f" = ".ssh" ] && continue
  [[ $f = *.md ]] && continue
  [[ $f = *.sh ]] && continue
  [[ $f = *.bash ]] && continue
  [[ $f = *.txt ]] && continue
  [[ $f = 30-touchpad.conf ]] && continue

  if [ -e $HOME/$f ]; then
    echo "Cannot deploy $f: $HOME/$f already exists"
  else
    ln -s $CWD/$f $HOME/$f
  fi
done

cd .config
CWD=$(pwd)
mkdir -p $HOME/.config
for f in * .*; do
  [ "$f" = "." ] && continue
  [ "$f" = ".." ] && continue
  if [ -e $HOME/.config/$f ]; then
    echo "Cannot deploy $f: $HOME/.config/$f already exists"
  else
    ln -s $CWD/$f $HOME/.config/$f
  fi
done
cd ..

cd .ssh
CWD=$(pwd)
mkdir -p $HOME/.ssh
if [[ -e $HOME/.ssh/config ]]; then
  echo "Cannot deploy .ssh/config: $HOME/.ssh/config already exists"
else
  ln -s $CWD/config $HOME/.ssh/config
fi
cd ..

echo "Deploying done"
