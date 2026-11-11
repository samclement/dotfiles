#!/usr/bin/env bash
# Arch Linux packages. Run directly, or via ./bootstrap.
set -euo pipefail

# All of these exist in `extra` (verified against a live Arch box).
sudo pacman -S --needed --noconfirm \
    git \
    ghq \
    zsh \
    tmux \
    neovim \
    go \
    eza \
    bat \
    zoxide \
    fzf \
    age \
    television \
    kitty \
    ttf-jetbrains-mono-nerd
