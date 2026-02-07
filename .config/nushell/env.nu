# env.nu - Nushell Environment Configuration

# --- Starship Prompt ---
mkdir ($nu.default-config-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.default-config-dir | path join "vendor/autoload/starship.nu")

# --- Environment Variables ---
$env.EDITOR = "vim"
$env.LANG = "en_US.UTF-8"

# --- ghq root ---
$env.GHQ_ROOT = ($env.HOME | path join "ghq")

# --- devbox global integration ---
# devbox global shellenv outputs env vars; source it if available
if (which devbox | is-not-empty) {
    devbox global shellenv --preserve-path-stack -r
        | lines
        | each { |line|
            if ($line | str starts-with "export ") {
                let kv = ($line | str replace "export " "" | split column "=" key value)
                let key = ($kv | get key.0)
                let val = ($kv | get value.0 | str replace -a '"' '')
                { key: $key, value: $val }
            }
        }
        | compact
        | reduce -f {} { |it, acc| $acc | merge { ($it.key): $it.value } }
        | load-env
}
