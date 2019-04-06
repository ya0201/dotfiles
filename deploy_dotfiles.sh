#!/bin/bash

CWD=`pwd`
echo "Deploying dotfiles ..."

for f in * .*; do
  [ "$f" = "." ] && continue
  [ "$f" = ".." ] && continue
  [ "$f" = "README.md" ] && continue
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [[ $f = *.sh ]] && continue

  if [ -e $HOME/$f ]; then
    echo "Cannot deploy $f: $HOME/$f already exists"
  else
    ln -s $CWD/$f $HOME/$f
  fi
done

echo "Deploying done"
