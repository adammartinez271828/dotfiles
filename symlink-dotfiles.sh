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
  ln -s $DIR/$dotfile ~/$dotfile
done
