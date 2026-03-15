# nvim-config

Neovim and tmux configuration.

## Installation

### Clone the repository

```bash
git clone https://github.com/martineberlein/nvim-config.git ~/.config/nvim
```

### Run the install script

```bash
chmod +x ~/.config/nvim/install.sh
~/.config/nvim/install.sh
```

The install script will:

1. Install system dependencies (Neovim, tmux, ripgrep, fd, Node.js, etc.) via `apt` on Linux or `brew` on macOS
2. Symlink the tmux config to `~/.tmux.conf`
3. Install TPM (Tmux Plugin Manager)
4. Install the JetBrains Mono Nerd Font

Once complete, open tmux, press `Prefix + I` to install tmux plugins, then launch `nvim`.

## Usage

### Start tmux

```bash
tmux
```

Press `Prefix + I` (default prefix is `Ctrl+b`) to install tmux plugins on first launch.

### Launch Neovim

```bash
nvim
```

Lazy.nvim will automatically install plugins on first launch.
