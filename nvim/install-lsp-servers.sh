#!/bin/bash
# Install LSP servers for Neovim

echo "🚀 Installing Language Servers..."
echo ""

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install Node.js first."
    exit 1
fi

# TypeScript/JavaScript
echo "📦 Installing TypeScript/JavaScript LSP..."
npm install -g typescript-language-server typescript

# HTML & CSS
echo "📦 Installing HTML/CSS LSP..."
npm install -g vscode-langservers-extracted

# Python
echo "🐍 Installing Python LSP..."
if command -v pip &> /dev/null || command -v pip3 &> /dev/null; then
    pip install pyright 2>/dev/null || pip3 install pyright
else
    echo "⚠️  pip not found, skipping Python LSP"
fi

# Lua (macOS)
echo "🌙 Installing Lua LSP..."
if command -v brew &> /dev/null; then
    brew install lua-language-server
else
    echo "⚠️  Homebrew not found, skipping Lua LSP"
    echo "   Install manually from: https://github.com/LuaLS/lua-language-server/releases"
fi

# Go
echo "🐹 Installing Go LSP..."
if command -v go &> /dev/null; then
    go install golang.org/x/tools/gopls@latest
else
    echo "⚠️  Go not found, skipping Go LSP"
fi

# Java
echo "☕ Installing Java LSP..."
if command -v brew &> /dev/null; then
    brew install jdtls
else
    echo "⚠️  Homebrew not found, skipping Java LSP"
    echo "   Install manually from: https://github.com/eclipse/eclipse.jdt.ls"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Installed language servers:"
echo ""
for cmd in typescript-language-server vscode-html-language-server vscode-css-language-server pyright lua-language-server gopls jdtls; do
    printf "  %-35s" "$cmd:"
    if command -v $cmd &> /dev/null; then
        echo "✓"
    else
        echo "✗"
    fi
done

echo ""
echo "🎉 Restart Neovim and open a file to test LSP features!"
echo ""
echo "Test LSP keybindings:"
echo "  gd         - Go to definition"
echo "  K          - Hover documentation"
echo "  <leader>rn - Rename symbol"
echo "  <leader>a  - Code actions"
echo "  [g / ]g    - Navigate diagnostics"
echo ""
