#!/usr/bin/env zsh

DEBUG_ENABLED=${DEBUG_ENABLED:-'true'}
echo "Deploying dotfiles ..."

CWD=$(pwd)
for f in ${(@f)"$(ls -a)"}; do
  [[ $f = "." ]] && continue
  [[ $f = ".." ]] && continue
  [[ $f = ".git" ]] && continue
  [[ $f = ".gitignore" ]] && continue
  [[ $f = ".github" ]] && continue
  [[ $f = ".config" ]] && continue
  [[ $f = ".ssh" ]] && continue
  [[ $f = *.md ]] && continue
  [[ $f = *.sh ]] && continue
  [[ $f = *.txt ]] && continue
  [[ $f = *.plist ]] && continue
  [[ $f = scripts ]] && continue
  [[ $f = legacy ]] && continue
  [[ $f = Makefile ]] && continue

  if [[ -e $HOME/$f ]]; then
    echo "Cannot deploy $f: $HOME/$f already exists"
  else
    [[ $DEBUG_ENABLED = 'true' ]] && echo "ln -s $CWD/$f $HOME/$f" >&2
    ln -s $CWD/$f $HOME/$f
  fi
done

cd .config
CWD=$(pwd)
mkdir -p $HOME/.config
for f in ${(@f)"$(ls -a)"}; do
  [[ $f = "." ]] && continue
  [[ $f = ".." ]] && continue
  if [[ -e $HOME/.config/$f ]]; then
    echo "Cannot deploy $f: $HOME/.config/$f already exists"
  else
    [[ $DEBUG_ENABLED = 'true' ]] && echo "ln -s $CWD/$f $HOME/.config/$f" >&2
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
  [[ $DEBUG_ENABLED = 'true' ]] && echo "ln -s $CWD/config $HOME/.ssh/config" >&2
  ln -s $CWD/config $HOME/.ssh/config
fi
cd ..

echo "Deploying done"
