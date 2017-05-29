#!/bin/bash

# Create a symlink for each dotfile in the home directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=(
    ".bash_aliases"
    ".gitconfig"
    ".githelpers"
    ".gitignore_global"
    ".tmux.conf"
    ".vimrc"
)

for dotfile in ${DOTFILES[@]}; do
  if [ -h ~/$dotfile ] ; then  # symlink
    echo "~/$dotfile: overwriting existing symlink..."
    ln -sf $DIR/$dotfile ~/$dotfile
  elif [ -e ~/$dotfile ] ; then  # any other file
    echo "~/$dotfile: file exists, skipping..."
  else  # no file
    echo "~/$dotfile: creating symlink..."
    ln -s $DIR/$dotfile ~/$dotfile
  fi
done

