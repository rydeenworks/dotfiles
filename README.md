# dotfiles

macOS terminal environment: zsh + Homebrew + Starship + iTerm2

## What's included

| File | Description |
|---|---|
| `Brewfile` | Homebrew packages (CLI tools, fonts, apps) |
| `.zshrc` | zsh config (oh-my-zsh, aliases, plugins) |
| `.zprofile` | brew shellenv, PATH |
| `.zshenv` | cargo env |
| `.gitconfig` | Git config (delta, ghq, aliases) |
| `.config/starship.toml` | Starship prompt |
| `iterm2/profile.json` | iTerm2 profile |
| `install.sh` | Setup script |

## Setup

```bash
# 1. Clone
ghq get rydeenworks/dotfiles
# or
git clone https://github.com/rydeenworks/dotfiles.git ~/ghq/github.com/rydeenworks/dotfiles

# 2. Run install script
cd ~/ghq/github.com/rydeenworks/dotfiles
./install.sh
```

The script will:
- Install Homebrew (if not present)
- Install all packages from `Brewfile`
- Install Oh My Zsh and plugins
- Create symlinks for config files (existing files are backed up as `.bak`)
- Set zsh as default shell

## Manual steps

### iTerm2 profile

Open iTerm2 > Profiles > Other Actions > Import JSON Profiles, then select `iterm2/profile.json`.

## Key tools

- **Shell**: zsh + [Oh My Zsh](https://ohmyz.sh/) (robbyrussell theme)
- **Prompt**: [Starship](https://starship.rs/)
- **Terminal**: [iTerm2](https://iterm2.com/)
- **Editor**: [Helix](https://helix-editor.com/)
- **Git**: [git-delta](https://github.com/dandavison/delta) (side-by-side diff), [ghq](https://github.com/x-motemen/ghq), [tig](https://jonas.github.io/tig/)
- **CLI**: [eza](https://eza.rocks/), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [fzf](https://github.com/junegunn/fzf), [bat](https://github.com/sharkdp/bat), [zoxide](https://github.com/ajeetdsouza/zoxide), [yazi](https://yazi-rs.github.io/)
