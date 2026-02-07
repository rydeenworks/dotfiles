# config.nu - Nushell Main Configuration

# ============================================================
# Aliases (familiar commands for zsh/fish migrants)
# ============================================================
alias ll = ls -l
alias la = ls -la
alias g = git
alias gs = git status
alias gd = git diff
alias gl = git log --oneline -20
alias cat = bat

# ============================================================
# ghq + fzf: Project Switcher
# ============================================================
def proj [] {
    let selected = (ghq list | fzf --height 40% --reverse | str trim)
    if ($selected | is-not-empty) {
        cd ([$env.GHQ_ROOT, $selected] | path join)
    }
}

# ============================================================
# Utilities
# ============================================================

# Quick HTTP GET and parse JSON response
def fetch [url: string] {
    http get $url
}

# Show system info as table
def sysinfo [] {
    {
        os: (sys host | get name)
        hostname: (sys host | get hostname)
        cpu: (sys cpu | get brand | first)
        memory: (sys mem | get total)
        shell: $env.SHELL?
    }
}
