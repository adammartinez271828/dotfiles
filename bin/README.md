# bin/

Personal scripts. This is a stow package: `bin/.local/bin/<script>` is linked
to `~/.local/bin/<script>` by `../install.sh` (or `stow bin`). Add new scripts
under `bin/.local/bin/`, make them executable, then `stow -R bin`.

## claude-rc

Runs [Claude Code Remote Control](https://code.claude.com/docs/en/remote-control)
servers in the background, one per project folder, so you can drive sessions on
this machine from claude.ai/code or the Claude mobile app without keeping a
terminal open.

Each server is a detached tmux session named `rc-<folder>`. Closing your
terminal doesn't stop it; you can attach later to see the QR code.

### Requirements

- `tmux` (`sudo pacman -S tmux`)
- Claude Code signed in via `/login` with a claude.ai account
- Run plain `claude` once in each project folder to accept the workspace-trust
  dialog. Without that, the server exits immediately. Trust is never saved for
  `$HOME` itself, so start servers from project folders, not `~`.

### Usage

```
claude-rc start [DIR] [remote-control flags...]   start a server for DIR (default: cwd)
claude-rc stop  [DIR|NAME]                        stop it (sessions resumable for ~4h)
claude-rc restart [DIR|NAME]
claude-rc ls                                      running servers, their folders, and URLs
claude-rc url   [DIR|NAME]                        just the URL
claude-rc attach [DIR|NAME]                       live terminal; space = QR code, w = toggle
                                                  spawn mode; Ctrl+B then D to detach
```

`DIR|NAME` accepts a path, the folder's basename, or the full `rc-<folder>`
tmux name. Examples:

```bash
claude-rc start ~/devel/home-dockerhost
claude-rc start . --spawn worktree --permission-mode acceptEdits
claude-rc start ~/devel/home-dockerhost --continue   # bring back a stopped server's sessions
claude-rc attach home-dockerhost
```

### Behaviour worth knowing

- **One server per folder; any number of folders.** Sessions a server creates
  all live in its start folder (or, with `--spawn worktree`, in git worktrees of
  that repo). A server started in `~/devel` cannot serve `~/devel/foo` as its
  own project, so start a separate server there instead. Never start two
  servers in the same folder.
- **Defaults added by the script:** `--name <folder>` so sessions are
  recognisable on your phone, and `--spawn same-dir` because without it
  `claude remote-control` asks interactively and would block forever in the
  background. Pass your own `--name` / `--spawn` to override.
- **The URL** is `https://claude.ai/code?environment=env_...`. Open it (or scan
  the QR code from `attach`) and new sessions are created in that folder. Up to
  32 concurrent sessions per server by default (`--capacity`).
- **`stop` sends Ctrl+C**, which lets Claude Code keep the served sessions
  resumable for about four hours: `claude-rc start DIR` (all of them) or
  `claude-rc start DIR --continue` (just the first). After that window the
  conversations still exist locally under `claude --resume`.
- **Network outage:** a server gives up after about 10 minutes offline and
  exits. `claude-rc ls` will no longer list it; start it again.
- **`claude-rc start` on a running folder** is a no-op that reprints the URL,
  so it's safe to call repeatedly.
