#!/bin/bash
# Install LSP servers for Neovim

set -e

echo "Installing LSP servers..."

# TypeScript/JavaScript
echo "Installing typescript-language-server..."
npm install -g typescript-language-server typescript

# HTML/CSS/JSON
echo "Installing vscode-langservers-extracted (HTML, CSS, JSON, ESLint)..."
npm install -g vscode-langservers-extracted

# Python
# Install pipx if you don't have it
brew install pipx

echo "Installing pyright..."
pipx install pyright

# Lua
echo "Installing lua-language-server..."
brew install lua-language-server

# Go
echo "Installing gopls..."
go install golang.org/x/tools/gopls@latest

# Java
echo "Installing jdtls..."
brew install jdtls

# Rust (if rustup is installed)
if command -v rustup &> /dev/null; then
    echo "Installing rust-analyzer..."
    rustup component add rust-analyzer
else
    echo "Skipping rust-analyzer (rustup not installed)"
fi

echo ""
echo "✓ LSP servers installation complete!"
echo ""
echo "Installed:"
echo "  - typescript-language-server (JS/TS)"
echo "  - vscode-langservers-extracted (HTML/CSS/JSON)"
echo "  - pyright (Python)"
echo "  - lua-language-server (Lua)"
echo "  - gopls (Go)"
echo "  - jdtls (Java)"
echo "  - rust-analyzer (Rust, if rustup available)"
echo ""
echo "Restart Neovim to use the language servers."
