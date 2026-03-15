#!/bin/bash
set -euo pipefail

OS="$(uname -s)"

# 1. System dependencies
if [ "$OS" = "Linux" ]; then
    sudo apt update && sudo apt install -y neovim tmux curl git unzip fontconfig build-essential ripgrep fd-find xclip npm nodejs || true
elif [ "$OS" = "Darwin" ]; then
    brew install neovim tmux curl git unzip fontconfig ripgrep fd npm node || true
fi

# 2. Symlink tmux config
ln -sf ~/.config/nvim/.tmux.conf ~/.tmux.conf

# 3. Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 4. Install JetBrains Mono Nerd Font
if [ "$OS" = "Darwin" ]; then
    FONT_DIR=~/Library/Fonts
else
    FONT_DIR=~/.local/share/fonts
fi

mkdir -p "$FONT_DIR"
curl -fLo "$FONT_DIR/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -q -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR/"
rm -f "$FONT_DIR/JetBrainsMono.zip"

if [ "$OS" = "Linux" ]; then
    fc-cache -fv
fi

echo "Setup complete! Open tmux, press 'Prefix + I', then launch nvim."
