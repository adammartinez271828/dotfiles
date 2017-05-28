#!/bin/bash

set -e

# Create a symlink for each dotfile in the home directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=(
    ".gitconfig"
    ".githelpers"
    ".tmux.conf"
)

for dotfile in ${DOTFILES[@]}; do
  ln -sf $DIR/$dotfile ~/$dotfile
done
