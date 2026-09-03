# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles (bash, git, tmux, vim, Claude Code) plus a `bin/` of personal scripts, deployed to `~` with GNU stow. There is no build or test step. Once deployed, files in `~` are symlinks into this checkout, so editing a file here changes the live config immediately.

Do not run `install.sh` or `stow` against the user's home directory as part of a change. Commit repo edits and let the user deploy after reviewing.

## Commands

```bash
./install.sh -n              # dry run of the full install
./install.sh                 # stow all packages, hook ~/.bashrc, install vim plugins
stow -R <package>            # restow one package after adding/removing a file in it
bash -n <file>               # syntax-check a shell file
shellcheck install.sh bin/.local/bin/claude-rc
```

## How things fit together

- **Packages mirror `~`.** `bash/.bash_aliases` becomes `~/.bash_aliases`, `git/.config/git/ignore` becomes `~/.config/git/ignore`. To add a dotfile, create it at the mirrored path inside the right package; there is no list to update. `bin/README.md` is excluded from stow via `bin/.stow-local-ignore`.
- **`.stowrc` forces `--no-folding`.** Stow links individual files and leaves `~/.vim`, `~/.config/git`, `~/.claude`, `~/.claude/skills` as real directories. This is what keeps vim-plug's `~/.vim/plugged`, anything git writes to `~/.config/git`, and Claude's credentials/history out of the repo. Never remove it.
- **`install.sh` uses `stow --adopt`.** A pre-existing real file in `~` is moved into the repo and shows in `git status`; the intended follow-up is `git checkout -- .`. Do not run `--adopt` casually on a deployed host, it overwrites repo files with the host's copies.
- **Bash loading chain:** `~/.bashrc` (host-specific, never tracked, never overwritten; install.sh appends one guarded source line) sources `.bash_dotfiles`, which adds `~/.local/bin` to PATH once and sources `.bash_aliases`, which chains `.bash_python_aliases` then `.bash_functions`. New aliases go in `.bash_aliases`, general functions in `.bash_functions`, python tooling (`venv`, `activate`) in `.bash_python_aliases`. Exported environment belongs in the host's `~/.bash_profile`, not in anything tracked here.
- **Git:** the global ignore is `git/.config/git/ignore`, git's default excludes path, so `.gitconfig` sets no `core.excludesfile`. Keep it short; global ignores hide files in every repo. Per-host git settings go in the untracked `~/.gitconfig.local`, which `.gitconfig` includes; never add host-specific values to the tracked file.
- **Vim:** `.vimrc` bootstraps vim-plug itself on first run (needs curl). Plugins are declared between `plug#begin` and `plug#end`; install headlessly with `vim -es -u ~/.vimrc -i NONE -c 'PlugInstall --sync' -c qa`.
- **Claude:** `claude/.claude/` tracks only `skills/`. `~/.claude/settings.json` is intentionally untracked (written by `/config` and `/auto-mode-setup`, per-machine, no user-level local override exists). Do not add it back.
- **tmux:** prefix is `C-a`.

## bin/claude-rc

Wraps `claude remote-control` in detached tmux sessions named `rc-<folder>`, one per project folder. Subcommands: `start`, `stop`, `restart`, `ls`, `url`, `attach`. It injects `--name <folder>` and `--spawn same-dir` unless the caller passes them, because without `--spawn` the underlying command prompts interactively and hangs in the background. `stop` sends Ctrl+C rather than killing so sessions stay resumable. It refuses to start in `$HOME`. Its `usage` prints lines 2-16 of the script's own header comment, so keep that header accurate when changing the CLI.
