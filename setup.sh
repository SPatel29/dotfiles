#!/usr/bin/env bash
# Links ~/.zshrc to the zshrc in this folder, installs Homebrew (if missing),
# the packages from Brewfile.* in this folder, and clones the nvim config.
#
# Usage:
#   ./setup.sh                 # install every Brewfile.*
#   ./setup.sh languages cli   # install only Brewfile.languages and Brewfile.cli
#   ./setup.sh --list          # show available Brewfiles
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

list_bundles() {
  for f in "$SCRIPT_DIR"/Brewfile.*; do
    [[ -e "$f" ]] && echo "${f##*/Brewfile.}"
  done
}

if [[ "${1:-}" == "--list" || "${1:-}" == "-l" ]]; then
  list_bundles
  exit 0
fi

# Link a dotfile into $HOME, backing up any existing file that isn't already the link
link_dotfile() {
  local src="$SCRIPT_DIR/$1" dest="$2"
  if [[ "$(readlink "$dest" 2>/dev/null)" == "$src" ]]; then
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
    echo "==> Backing up existing $dest to $backup"
    mv "$dest" "$backup"
  fi
  echo "==> Linking $dest -> $src"
  ln -s "$src" "$dest"
}

link_dotfile zshrc "$HOME/.zshrc"

# Install Homebrew if it isn't already available
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Homebrew not found, installing..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this shell (it may have just been installed)
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done

if ! command -v brew >/dev/null 2>&1; then
  echo "Error: brew is still not on PATH after install." >&2
  exit 1
fi

# Pick which bundles to install: arguments, or all of them
if [[ $# -gt 0 ]]; then
  bundles=("$@")
else
  mapfile -t bundles < <(list_bundles)
fi

if [[ ${#bundles[@]} -eq 0 ]]; then
  echo "No Brewfile.* files found in $SCRIPT_DIR" >&2
  exit 1
fi

brew update

for name in "${bundles[@]}"; do
  file="$SCRIPT_DIR/Brewfile.$name"
  if [[ ! -f "$file" ]]; then
    echo "Error: $file not found. Available: $(list_bundles | tr '\n' ' ')" >&2
    exit 1
  fi
  echo "==> Installing $name ($file)"
  brew bundle --file="$file"
done

# Neovim config (separate repo). Left alone if it already exists; update it with `git pull`.
NVIM_CONFIG_REPO="https://github.com/SPatel29/nvim-config.git"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [[ -e "$NVIM_CONFIG_DIR" ]]; then
  echo "==> $NVIM_CONFIG_DIR already exists, skipping nvim config"
else
  echo "==> Cloning nvim config into $NVIM_CONFIG_DIR"
  mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
  git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
fi

echo "==> Done."
