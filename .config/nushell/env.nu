# env.nu - Nushell Environment Configuration

# --- Environment Variables ---
$env.EDITOR = "vim"
$env.LANG = "en_US.UTF-8"
$env.GHQ_ROOT = ($env.HOME | path join "ghq")

# --- devbox global integration ---
# devbox PATH を brew より先に通す (Prepend)
let devbox_bin = ($env.HOME | path join ".local/share/devbox/global/default/.devbox/nix/profile/default/bin")
if ($devbox_bin | path exists) {
    $env.PATH = ($env.PATH | prepend $devbox_bin)
}

# --- Starship Prompt ---
# devbox PATH 設定後に初期化 (starship コマンドが見つかるように)
if (which starship | is-not-empty) {
    mkdir ($nu.default-config-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.default-config-dir | path join "vendor/autoload/starship.nu")
}
