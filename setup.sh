#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="backup-$(date +%Y%m%d-%H%M%S)"

info() {
  printf '\n==> %s\n' "$1"
}

warn() {
  printf '\nWarning: %s\n' "$1" >&2
}

die() {
  printf '\nError: %s\n' "$1" >&2
  exit 1
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    die "$1 is required."
  fi
}

install_formula() {
  local package="$1"

  if brew list --formula "$package" >/dev/null 2>&1; then
    info "$package is already installed."
  else
    info "Installing $package..."
    brew install "$package"
  fi
}

install_cask() {
  local package="$1"

  if brew list --cask "$package" >/dev/null 2>&1; then
    info "$package is already installed."
  else
    info "Installing $package..."
    brew install --cask "$package"
  fi
}

link_path() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" ]]; then
    if [[ "$(readlink "$target")" == "$source" ]]; then
      info "Already linked: $target"
      return
    fi

    info "Removing old symbolic link: $target"
    rm "$target"
  elif [[ -e "$target" ]]; then
    local backup="${target}.${BACKUP_SUFFIX}"
    info "Backing up $target -> $backup"
    mv "$target" "$backup"
  fi

  info "Linking $target -> $source"
  ln -s "$source" "$target"
}

setup_wezterm() {
  info "Setting up WezTerm"

  if brew list --cask wezterm >/dev/null 2>&1; then
    die "Stable WezTerm is installed. Uninstall it first with: brew uninstall --cask wezterm"
  fi

  install_cask "wezterm@nightly"
  install_cask "font-meslo-for-powerlevel10k"

  link_path \
    "$DOTFILES_DIR/wezterm/wezterm.lua" \
    "$HOME/.config/wezterm/wezterm.lua"

  link_path \
    "$DOTFILES_DIR/wezterm/keybinds.lua" \
    "$HOME/.config/wezterm/keybinds.lua"
}

setup_nvim() {
  info "Setting up Neovim"

  install_formula "neovim"
  install_formula "gopls"

  link_path \
    "$DOTFILES_DIR/init.lua" \
    "$HOME/.config/nvim/init.lua"

  link_path \
    "$DOTFILES_DIR/lua" \
    "$HOME/.config/nvim/lua"
}

verify() {
  info "Verifying setup"

  command -v nvim >/dev/null 2>&1 || die "nvim was not found in PATH."
  command -v gopls >/dev/null 2>&1 || die "gopls was not found in PATH."
  command -v wezterm >/dev/null 2>&1 || die "wezterm was not found in PATH."

  [[ -L "$HOME/.config/nvim/init.lua" ]] || die "~/.config/nvim/init.lua is not a symbolic link."
  [[ -L "$HOME/.config/nvim/lua" ]] || die "~/.config/nvim/lua is not a symbolic link."
  [[ -L "$HOME/.config/wezterm/wezterm.lua" ]] || die "~/.config/wezterm/wezterm.lua is not a symbolic link."
  [[ -L "$HOME/.config/wezterm/keybinds.lua" ]] || die "~/.config/wezterm/keybinds.lua is not a symbolic link."

  info "Installed versions"
  nvim --version | head -n 1
  gopls version | head -n 1
  wezterm --version

  info "Symbolic links"
  ls -l "$HOME/.config/nvim/init.lua"
  ls -ld "$HOME/.config/nvim/lua"
  ls -l "$HOME/.config/wezterm/wezterm.lua"
  ls -l "$HOME/.config/wezterm/keybinds.lua"

  info "Verification passed."
}

show_usage() {
  cat <<'EOF'
Usage: ./setup.sh [all|wezterm|nvim|verify]

Commands:
  all      Install and configure WezTerm and Neovim. This is the default.
  wezterm  Install and configure only WezTerm.
  nvim     Install and configure only Neovim.
  verify   Verify installed commands and symbolic links.
EOF
}

main() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    die "This setup script currently supports macOS only."
  fi

  require_command "brew"
  require_command "git"

  case "${1:-all}" in
    all)
      setup_wezterm
      setup_nvim
      verify
      ;;
    wezterm)
      setup_wezterm
      ;;
    nvim|neovim)
      setup_nvim
      ;;
    verify)
      verify
      ;;
    -h|--help|help)
      show_usage
      ;;
    *)
      show_usage
      exit 1
      ;;
  esac
}

main "$@"
