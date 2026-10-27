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
- `terminal-appearance.zsh`: prompt, colors, and the Material Palenight color scheme
- Neovim config, cloned from [nvim-config](https://github.com/SPatel29/nvim-config) into `~/.config/nvim`

## Install

```bash
git clone https://github.com/SPatel29/dotfiles.git ~/development/dotfiles
~/development/dotfiles/setup.sh
```

Then open a new terminal.

`setup.sh` installs Homebrew if needed, installs everything above, and links `~/.zshrc`. An existing `~/.zshrc` gets backed up first.

**Install only some Brewfiles:**
```bash
./setup.sh cli          # just Brewfile.cli
./setup.sh --list       # show all Brewfiles
```

## Notes

- Run `dotup` to pull the latest dotfiles and nvim config. Run `./setup.sh` again if a Brewfile changed.
- Put secrets and machine-only settings in `~/.zshrc.local`. It's loaded automatically and not saved in git.
- Java may need adding to your PATH. See the note in `Brewfile.languages`.
- To add a tool, add it to a Brewfile and run `./setup.sh` again.
