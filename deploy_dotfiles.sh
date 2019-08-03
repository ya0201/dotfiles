#!/bin/bash

echo "Deploying dotfiles ..."

CWD=$(pwd)
for f in * .*; do
  [ "$f" = "." ] && continue
  [ "$f" = ".." ] && continue
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".config" ] && continue
  [[ $f = *.md ]] && continue
  [[ $f = *.sh ]] && continue
  [[ $f = *.txt ]] && continue

  if [ -e $HOME/$f ]; then
    echo "Cannot deploy $f: $HOME/$f already exists"
  else
    ln -s $CWD/$f $HOME/$f
  fi
done

cd .config
CWD=$(pwd)
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

echo "Deploying done"
