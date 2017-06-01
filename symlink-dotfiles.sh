#!/bin/bash

# Create a symlink for each dotfile in the home directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=(
    ".bash_aliases"
    ".bash_functions"
    ".gitconfig"
    ".githelpers"
    ".gitignore_global"
    ".tmux.conf"
    ".vim"
    ".vimrc"
)

for dotfile in ${DOTFILES[@]}; do
    if [ -h ~/$dotfile ]; then  # symlink
        echo "~/$dotfile: overwriting existing symlink..."
        ln -snf $DIR/$dotfile ~/$dotfile
    elif [ -e ~/$dotfile ]; then  # any other file
        echo "~/$dotfile: file exists, skipping..."
    else  # no file
        echo "~/$dotfile: creating symlink..."
        ln -s $DIR/$dotfile ~/$dotfile
    fi
done
