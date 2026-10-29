# dotfiles

My dev setup. One script installs my tools and sets up my terminal on macOS or Linux (including WSL).

## What it installs

**Languages** (`Brewfile.languages`)
- node (includes npm)
- python
- openjdk (Java)

**CLI tools** (`Brewfile.cli`)
- git, gh, neovim, tree-sitter-cli
- ripgrep, fd, fzf, jq, lazygit
- tmux, wget, make, unzip
- zsh-autosuggestions, zsh-syntax-highlighting

**Config**
- `zshrc`: shell setup, linked to `~/.zshrc`
- `tmux.conf`: tmux setup and shortcuts, linked to `~/.tmux.conf`
- `terminal-appearance.zsh`: prompt, colors, and the Material Palenight color scheme
- Neovim config, cloned from [nvim-config](https://github.com/SPatel29/nvim-config) into `~/.config/nvim`

## Install

```bash
git clone https://github.com/SPatel29/dotfiles.git ~/development/dotfiles
~/development/dotfiles/setup.sh
```

Then open a new terminal.

`setup.sh` installs Homebrew if needed, installs everything above, and links `~/.zshrc` and `~/.tmux.conf`. Existing files get backed up first.

**Install only some Brewfiles:**
```bash
./setup.sh cli          # just Brewfile.cli
./setup.sh --list       # show all Brewfiles
```

## Update

On a machine that's already set up:

```bash
dotup                              # pull the latest dotfiles and nvim config
~/development/dotfiles/setup.sh    # only if a Brewfile changed
```

If you only changed `zshrc` or the nvim config, `dotup` is enough. Then open a new terminal.

## Notes

- Put secrets and machine-only settings in `~/.zshrc.local`. It's loaded automatically and not saved in git.
- Java may need adding to your PATH. See the note in `Brewfile.languages`.
- To add a tool, add it to a Brewfile and run `./setup.sh` again.
- Keep new terminals fast (about 0.5s). Check with `time zsh -l -i -c exit`. The usual slow spots are `eval "$(tool init)"` lines, nvm, and generating completions in `~/.zshrc.local` or `~/.zprofile`.

## tmux shortcuts

Prefix is `Ctrl-b`. Press it, let go, then press the key.

| Keys | Action |
|---|---|
| `tmux` / `tmux a` | Start / reattach to last session |
| `prefix d` | Detach (session keeps running) |
| `prefix \|` / `prefix -` | Split side by side / top and bottom |
| `prefix h j k l` or `Alt+arrows` | Move between panes |
| `prefix H J K L` | Resize pane |
| `prefix z` | Zoom pane (toggle) |
| `prefix x` | Close pane |
| `prefix c` | New window |
| `Shift+←/→` or `prefix 1-9` | Switch windows |
| `prefix ,` | Rename window |
| `prefix s` | List sessions |
| `prefix [` | Scroll / copy mode (`v` select, `y` copy, `Esc` exit) |
| `prefix r` | Reload config |

Mouse works too: click to pick a pane, drag borders to resize, scroll to see history.
