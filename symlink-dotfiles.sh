#!/bin/bash

set -e

# Create a symlink for each dotfile in the home directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=(
    ".githelpers"
    ".gitconfig"
)

for dotfile in ${DOTFILES[@]}; do
  ln -sf $DIR/$dotfile ~/$dotfile
done
