# ~/.zshrc is a symlink to this file (created by setup.sh)

# Folder this file lives in, resolved through the symlink
DOTFILES="${${(%):-%x}:A:h}"

# Homebrew (macOS Apple Silicon, macOS Intel, Linux)
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done
export PATH="$HOME/.local/bin:$PATH"

# Tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive

# Prompt, ls colors, completion colors, plugin colors
source "$DOTFILES/terminal-appearance.zsh"

if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"   # set by `brew shellenv` above; skips a slow brew call

  # Fish-style suggestions from history (accept with →)
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

  # fzf keybindings (Ctrl-R history, Ctrl-T files, Alt-C cd)
  command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
fi

# Pull the latest dotfiles and nvim config
dotup() {
  echo "==> dotfiles"
  git -C "$DOTFILES" pull --ff-only
  echo "==> nvim-config"
  git -C "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" pull --ff-only
}

# Machine-specific settings and secrets (not tracked in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Command syntax highlighting (must be sourced last)
[[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
