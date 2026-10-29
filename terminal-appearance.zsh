# Terminal appearance: prompt, file/dir colors, completion colors, plugin colors.
# Sourced by zshrc (after compinit, before the zsh plugins).
#
# Color names below (cyan, green, ...) come from the terminal's color scheme,
# Material Palenight, saved at the bottom of this file.

# ---------------------------------------------------------------------------
# Prompt:  sunny_patel ~/dotfiles %
#   %n     user               -> cyan   (#71C6E7)
#   %~     path from home (~) -> green  (#ABCF76)
#   %%     prompt symbol      -> bold, default foreground (#A6ACCD)
# ---------------------------------------------------------------------------
PROMPT="%F{cyan}%n%f %F{green}%~%f %B%% %b"

# ---------------------------------------------------------------------------
# ls colors (dircolors defaults)
#   directories      bold blue      (di=01;34)
#   symlinks         bold cyan      (ln=01;36)
#   executables      bold green     (ex=01;32)
#   archives         bold red       (.zip .tar .gz .deb .jar ...)
#   images / video   bold magenta   (.png .jpg .svg .mp4 ...)
#   audio            cyan           (.mp3 .wav .flac ...)
#   backups / temp   gray           (*~ .bak .swp .tmp ...)
#   sockets          bold magenta,  pipes / devices  yellow on black
#   setuid           white on red,  setgid           black on yellow
#   world-writable dirs  blue on green (sticky: black on green)
# ---------------------------------------------------------------------------
if command -v dircolors >/dev/null 2>&1; then
  # Linux / WSL (GNU ls)
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
else
  # macOS (BSD ls): closest match to the dircolors defaults above
  export CLICOLOR=1
  export LSCOLORS="ExGxFxdaCxDaDahbadacec"
  # Used by completion colors below
  export LS_COLORS="di=01;34:ln=01;36:so=01;35:pi=40;33:ex=01;32:bd=40;33;01:cd=40;33;01:su=37;41:sg=30;43:tw=30;42:ow=34;42"
fi

# ---------------------------------------------------------------------------
# Tab completion menu: colored the same as ls
# ---------------------------------------------------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---------------------------------------------------------------------------
# zsh-autosuggestions: suggested text in bright black / gray (#676E95)
# ---------------------------------------------------------------------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# zsh-syntax-highlighting: using the plugin defaults
#   valid commands green, unknown commands red, strings yellow,
#   $variables in "double quotes" cyan, globs / history expansion blue

# ---------------------------------------------------------------------------
# Font: none set, so Windows Terminal's default is used: Cascadia Mono, size 12.
#
# Color scheme: Material Palenight (matches the Neovim `material` palenight theme).
# Windows Terminal: paste into "schemes" in settings.json, then set
# "colorScheme": "Material Palenight" on the Ubuntu profile.
# iTerm2: import "Material Palenight.itermcolors" from this folder
#   (Settings > Profiles > Colors > Color Presets... > Import, then pick it from the same menu).
# Other terminals (Ghostty, ...): use the same hex values.
#
# {
#     "name": "Material Palenight",
#     "background": "#292D3E",
#     "foreground": "#A6ACCD",
#     "cursorColor": "#FFCC00",
#     "selectionBackground": "#444267",
#     "black": "#3A3F58",
#     "red": "#DC6068",
#     "green": "#ABCF76",
#     "yellow": "#E6B455",
#     "blue": "#6E98EB",
#     "purple": "#B480D6",
#     "cyan": "#71C6E7",
#     "white": "#A6ACCD",
#     "brightBlack": "#676E95",
#     "brightRed": "#F07178",
#     "brightGreen": "#C3E88D",
#     "brightYellow": "#FFCB6B",
#     "brightBlue": "#82AAFF",
#     "brightPurple": "#C792EA",
#     "brightCyan": "#89DDFF",
#     "brightWhite": "#EEFFFF"
# }
# ---------------------------------------------------------------------------
