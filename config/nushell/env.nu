# Nushell Environment Config File

# prompt
let-env PROMPT_INDICATOR = { "❯ " }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "❯ " }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
}

let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

load-env {
    "XDG_CONFIG_DIR": $"($env.HOME)/.config",
    "XDG_DATA_DIR": $"($env.HOME)/.local/share",
    "XDG_CACHE_DIR": $"($env.HOME)/.cache",
    "XDG_DESKTOP_DIR": $"($env.HOME)/desktop",
    "XDG_DOCUMENTS_DIR": $"($env.HOME)/docs",
    "XDG_DOWNLOAD_DIR": $"($env.HOME)/dl",
    "XDG_MUSIC_DIR": $"($env.HOME)/media/music",
    "XDG_PICTURES_DIR": $"($env.HOME)/media/img",
    "XDG_PUBLICSHARE_DIR": $"($env.HOME)/tmp/publicshare",
    "XDG_TEMPLATES_DIR": $"($env.HOME)/tmp/templates",
    "XDG_VIDEOS_DIR": $"($env.HOME)/media/vid",
}

load-env {
    "EDITOR": "hx",
    "VISUAL": "bat",
    "TERMINAL": "alacritty",
    "BROWSER": "brave",
    "TASKMGR": "btop",
    "FILEMGR": "nnn",
    "MYSCRIPTS" : "~/script",
}

load-env {
    "RUSTUP_HOME": $"($env.XDG_DATA_DIR)/rustup",
    "CARGO_HOME": $"($env.XDG_DATA_DIR)/cargo",
    "CARGO_TARGET_DIR": $"($env.XDG_CACHE_DIR)/target",
}

let-env PATH = ($env.PATH | split row (char esep) | prepend $env.MYSCRIPTS | prepend $"($env.CARGO_HOME)/bin")
let-env PATH = ($env.PATH | prepend $"($env.CARGO_HOME)/bin" | prepend $env.MYSCRIPTS | prepend "~/.nix-profile/bin" | prepend "prefix/bin")

