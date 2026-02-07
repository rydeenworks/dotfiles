#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ============================================================
# OS Detection
# ============================================================
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                echo "wsl"
            else
                echo "linux"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

OS=$(detect_os)
echo "Detected OS: $OS"

# ============================================================
# Install devbox (if not present)
# ============================================================
if ! command -v devbox &>/dev/null; then
    echo "Installing devbox..."
    curl -fsSL https://get.jetify.com/devbox | bash
fi

# ============================================================
# devbox global install
# ============================================================
echo "Installing devbox global packages..."
cp "$DOTFILES_DIR/devbox.json" "$HOME/.local/share/devbox/global/default/devbox.json" 2>/dev/null || {
    devbox global init
    cp "$DOTFILES_DIR/devbox.json" "$(devbox global path)/devbox.json"
}
devbox global install

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
create_link "$DOTFILES_DIR/.config/nushell/config.nu" "$HOME/.config/nushell/config.nu"
create_link "$DOTFILES_DIR/.config/nushell/env.nu"    "$HOME/.config/nushell/env.nu"
create_link "$DOTFILES_DIR/.config/starship.toml"     "$HOME/.config/starship.toml"

# ============================================================
# ghq root directory
# ============================================================
mkdir -p "$HOME/ghq"

# ============================================================
# Set Nushell as default shell (optional, prompt user)
# ============================================================
NUSHELL_PATH="$(which nu 2>/dev/null || echo "")"
if [ -n "$NUSHELL_PATH" ]; then
    echo ""
    read -p "Set Nushell ($NUSHELL_PATH) as default shell? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! grep -q "$NUSHELL_PATH" /etc/shells; then
            echo "$NUSHELL_PATH" | sudo tee -a /etc/shells
        fi
        chsh -s "$NUSHELL_PATH"
        echo "Default shell changed to Nushell."
    fi
fi

echo ""
echo "Done! Start a new shell or run: exec nu"
