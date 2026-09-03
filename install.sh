#!/usr/bin/env bash
# Deploy these dotfiles into $HOME with GNU stow.
#
#   ./install.sh        stow every package, hook ~/.bashrc, install vim plugins
#   ./install.sh -n     dry run: show what stow would do, change nothing
#
# Packages mirror $HOME: bash/.bash_aliases -> ~/.bash_aliases, etc.
# .stowrc supplies --target=~ --no-folding --verbose, so directories like
# ~/.vim, ~/.config/git and ~/.claude/skills stay real directories and only
# files get linked. That keeps vim-plug, git and Claude Code from writing
# into this repo.

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

PACKAGES=(bash git tmux vim claude bin)

dry_run=0
case "${1:-}" in
    -n|--dry-run) dry_run=1 ;;
    "") ;;
    *) echo "usage: $0 [-n]" >&2; exit 2 ;;
esac

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU stow is required. Install it first:" >&2
    echo "  Arch:   sudo pacman -S stow" >&2
    echo "  Debian: sudo apt install stow" >&2
    exit 1
fi

# 1. Remove symlinks left by the old symlink-dotfiles.sh (they pointed at the
#    repo root, which no longer holds the dotfiles).
legacy=(
    ~/.bash_aliases ~/.bash_functions ~/.bash_python_aliases
    ~/.gitconfig ~/.gitignore_global ~/.tmux.conf ~/.vim ~/.vimrc
    ~/.local/bin/claude-rc
)
for f in "${legacy[@]}"; do
    if [ -L "$f" ] && [[ "$(readlink "$f")" == "$PWD"/* ]]; then
        echo "removing legacy symlink $f"
        (( dry_run )) || rm "$f"
    fi
done

# 2. Pre-create directories so stow links files into them rather than
#    creating the directories itself (belt and braces alongside --no-folding).
(( dry_run )) || mkdir -p ~/.local/bin ~/.config/git ~/.vim ~/.claude/skills

# 3. Stow. --adopt moves any pre-existing real file (e.g. a host's own
#    ~/.gitconfig) INTO the repo and links it back, so the difference shows up
#    in `git status` for review instead of aborting with a conflict.
if (( dry_run )); then
    stow --simulate "${PACKAGES[@]}"
    echo "dry run only; nothing changed"
    exit 0
fi
stow --adopt "${PACKAGES[@]}"

if [ -n "$(git status --porcelain)" ]; then
    cat <<'MSG'

NOTE: stow --adopt pulled pre-existing host files into the repo. Review them:

    git status --short
    git diff

then restore the repo versions with:

    git checkout -- .

(or keep the host's changes and commit them).
MSG
fi

# 4. Hook ~/.bashrc without replacing it.
hook='[ -f ~/.bash_dotfiles ] && . ~/.bash_dotfiles'
if ! grep -qF '.bash_dotfiles' ~/.bashrc 2>/dev/null; then
    printf '\n# dotfiles (see ~/devel/dotfiles)\n%s\n' "$hook" >> ~/.bashrc
    echo "appended source line to ~/.bashrc"
fi

# 5. Install vim plugins headlessly (the .vimrc bootstraps vim-plug itself).
if command -v vim >/dev/null 2>&1; then
    echo "installing vim plugins..."
    vim -es -u ~/.vimrc -i NONE -c 'PlugInstall --sync' -c 'qa' || true
fi

echo "done"
