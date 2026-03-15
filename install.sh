#!/bin/bash

# 1. System dependencies (Debian/Ubuntu)
sudo apt update && sudo apt install -y neovim tmux curl git unzip fontconfig build-essential ripgrep fd-find xclip npm nodejs

# 2. Clone Neovim config
git clone https://github.com/martineberlein/nvim-config.git ~/.config/nvim

# 3. Symlink tmux config
ln -sf ~/.config/nvim/.tmux.conf ~/.tmux.conf

# 4. Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 5. Install JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -q -o ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv

echo "Setup complete! Open tmux, press 'Prefix + I', then launch nvim."
