# Dotfiles

Personal configuration for my Arch workstation and Debian dockerhost, deployed
with [GNU stow](https://www.gnu.org/software/stow/).

## Install

```bash
sudo pacman -S stow        # or: sudo apt install stow
git clone <this repo> ~/devel/dotfiles
cd ~/devel/dotfiles
./install.sh -n            # dry run
./install.sh
```

`install.sh` stows every package, appends one source line to `~/.bashrc`, and
installs vim plugins. It never replaces `~/.bashrc`; host-specific things
(PATH, CUDA, ssh-agent) stay there.

If a real file already exists where a link should go (typically `~/.gitconfig`
on a fresh host), stow adopts it into the repo so the difference is visible in
`git status`. Review it, then `git checkout -- .` to restore the repo version.

## Layout

Each top-level directory is a stow package that mirrors `$HOME`:

| package  | installs                                                       |
|----------|----------------------------------------------------------------|
| `bash/`  | `~/.bash_dotfiles` (entry point), `.bash_aliases`, `.bash_functions`, `.bash_python_aliases` |
| `git/`   | `~/.gitconfig`, `~/.config/git/ignore` (global ignore)         |
| `tmux/`  | `~/.tmux.conf`                                                 |
| `vim/`   | `~/.vimrc` (vim-plug, self-bootstrapping), `~/.vim/colors/`    |
| `claude/`| `~/.claude/settings.json`, `~/.claude/skills/`                 |
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
  when they exist. Never add anything else from `~/.claude` (credentials,
  history, projects, sessions, cache).
- `settings.json` holds no secrets, but note git does not preserve its 0600
  mode.

### Bash

`~/.bashrc` sources `~/.bash_dotfiles`, which sources `.bash_aliases`, which
chains `.bash_python_aliases` and `.bash_functions`. On Debian the stock
`.bashrc` also sources `.bash_aliases`; running it twice is harmless.
