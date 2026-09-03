# Dotfiles

Personal configuration for my Arch workstation and Debian dockerhost, deployed
with [GNU stow](https://www.gnu.org/software/stow/).

## Install

```bash
sudo pacman -S stow        # or: sudo apt install stow
git clone git@github.com:adammartinez271828/dotfiles.git ~/devel/dotfiles
cd ~/devel/dotfiles
./install.sh -n            # dry run
./install.sh
```

`install.sh` stows every package, appends one source line to `~/.bashrc`, and
installs vim plugins. It never replaces `~/.bashrc` or `~/.bash_profile`;
host-specific things (CUDA, LM Studio, ssh-agent socket) stay there.

If a real file already exists where a link should go (typically `~/.gitconfig`
on a fresh host), stow adopts it into the repo so the difference is visible in
`git status`. Review it, then `git checkout -- .` to restore the repo version.
Anything host-only from that file belongs in `~/.gitconfig.local` (see Git).

## Layout

Each top-level directory is a stow package that mirrors `$HOME`:

| package  | installs                                                       |
|----------|----------------------------------------------------------------|
| `bash/`  | `~/.bash_dotfiles` (entry point), `.bash_aliases`, `.bash_functions`, `.bash_python_aliases` |
| `git/`   | `~/.gitconfig` (includes `~/.gitconfig.local`), `~/.config/git/ignore` |
| `tmux/`  | `~/.tmux.conf`                                                 |
| `vim/`   | `~/.vimrc` (vim-plug, self-bootstrapping), `~/.vim/colors/`    |
| `claude/`| `~/.claude/skills/`                                            |
| `bin/`   | `~/.local/bin/claude-rc` (see [bin/README.md](bin/README.md))  |

`.stowrc` sets `--target=~ --no-folding`, so directories such as `~/.vim`,
`~/.config/git` and `~/.claude/skills` are real directories and only files are
symlinked. Plugins land in `~/.vim/plugged`, outside the repo.

### Adding or changing files

- Put the file under `<package>/` at the path it should have relative to `~`,
  then run `stow -R <package>` (restow) so the new link is created.
- Because of `--no-folding`, a file created directly in `~/.claude/skills/` or
  `~/.vim/colors/` is not tracked until you move it into the package and restow.
- `~/.claude/CLAUDE.md` and `~/.claude/keybindings.json` belong in `claude/`
  when they exist. `~/.claude/settings.json` is deliberately not tracked: it
  is written by `/config` and `/auto-mode-setup`, holds per-machine and
  per-project content, and Claude Code has no user-level local override file
  to split it. Recreate it with `/config` on a new machine. Never add anything
  else from `~/.claude` (credentials, history, projects, sessions, cache).

### Bash

`~/.bashrc` sources `~/.bash_dotfiles`, which puts `~/.local/bin` on `PATH`
(once, guarded) and sources `.bash_aliases`, which chains
`.bash_python_aliases` (python alias, `venv` and `activate` functions) and
`.bash_functions`. On Debian the stock `.bashrc` also sources `.bash_aliases`;
running it twice is harmless.

The untracked host files follow the usual split: exported environment (PATH
additions, CUDA, `SSH_AUTH_SOCK`) goes in `~/.bash_profile`, which runs once per
login; aliases, prompt and the `.bash_dotfiles` source line go in `~/.bashrc`,
which runs for every interactive shell. SDDM starts the KDE session through a
bash login shell, so `~/.bash_profile` reaches GUI apps too. Variables that
systemd user services need (the ssh-agent socket) also go in
`~/.config/environment.d/*.conf`.

### Git

`~/.gitconfig` ends with `[include] path = ~/.gitconfig.local`. Put per-host
settings there (a different email, a signing key); git skips the file silently
when it is absent, and the global ignore keeps it out of every repo.
