# Aliases
alias g=git
alias gst='git status'
alias gaa='g add .'

alias ei="eza --icons --git"
alias ea="eza -a --icons --git"
alias ee="eza -aahl --icons --git"
alias et="eza -T -L 3 -a -I 'node_modules|.git|.cache|.DS_Store' --icons"
alias eta="eza -T -a -I 'node_modules|.git|.cache|.DS_Store' --color=always --icons | less -r"
alias ls=ei
alias la=ea
alias ll=ee
alias lt=et
alias lta=eta
alias l="clear && ls"
alias ai="zellij --layout ai"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-completions
)
source $ZSH/oh-my-zsh.sh

# yazi: cd to last visited directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Tools
eval "$(zoxide init zsh)"

# uv (Python)
. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Homebrew zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
