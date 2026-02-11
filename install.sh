#!/bin/bash
set -euo pipefail

# macOS dotfiles setup script

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ============================================================
# Require macOS
# ============================================================
if [ "$(uname -s)" != "Darwin" ]; then
    echo "Error: This script is for macOS only."
    exit 1
fi

# ============================================================
# Install Homebrew (if not present)
# ============================================================
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================
# Install packages via Brewfile
# ============================================================
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ============================================================
# Install Oh My Zsh (if not present)
# ============================================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ============================================================
# Install zsh plugins for Oh My Zsh
# ============================================================
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    echo "Installing zsh-completions plugin..."
    git clone https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM/plugins/zsh-completions"
fi

# ============================================================
# Symlinks
# ============================================================
create_link() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        mv "$dst" "${dst}.bak"
        echo "Backed up existing $dst -> ${dst}.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked: $dst -> $src"
}

echo "Creating symlinks..."
create_link "$DOTFILES_DIR/.zshrc"               "$HOME/.zshrc"
create_link "$DOTFILES_DIR/.zprofile"             "$HOME/.zprofile"
create_link "$DOTFILES_DIR/.zshenv"               "$HOME/.zshenv"
create_link "$DOTFILES_DIR/.gitconfig"            "$HOME/.gitconfig"
create_link "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# ============================================================
# ghq root directory
# ============================================================
mkdir -p "$HOME/ghq"

# ============================================================
# Set zsh as default shell
# ============================================================
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
    echo "Setting zsh as default shell..."
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_PATH"
fi

echo ""
echo "Done! Restart your terminal to apply changes."
echo ""
echo "Manual steps:"
echo "  1. Open iTerm2 > Profiles > Other Actions > Import JSON Profiles"
echo "     Import: $DOTFILES_DIR/iterm2/profile.json"
