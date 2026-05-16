#!/usr/bin/env bash
set -e

NVIM_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Detecting package manager..."

if command -v apt &>/dev/null; then
  PKG="apt"
elif command -v brew &>/dev/null; then
  PKG="brew"
else
  echo "ERROR: No supported package manager found (apt or brew)." >&2
  exit 1
fi

install_pkg() {
  if [ "$PKG" = "apt" ]; then
    sudo apt install -y "$1"
  else
    brew install "$1"
  fi
}

echo "==> Installing system dependencies..."

command -v fzf &>/dev/null   || install_pkg fzf
command -v rg &>/dev/null    || install_pkg ripgrep
command -v nvim &>/dev/null  || install_pkg neovim

echo "==> Linking config..."
mkdir -p ~/.config
if [ "$(realpath ~/.config/nvim 2>/dev/null)" != "$NVIM_CONFIG_DIR" ]; then
  [ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak && echo "    Backed up existing config to ~/.config/nvim.bak"
  ln -s "$NVIM_CONFIG_DIR" ~/.config/nvim
fi

echo ""
echo "==> Done. Open nvim to complete setup:"
echo "    - Lazy will install all plugins automatically"
echo "    - Mason will install LSP servers and formatters"
echo "    - Treesitter will install the cpp parser"
