# Cross-platform Home Manager config: shell, editors, VCS, CLI/dev tooling.
# Shared by every host (darwin + nixos). Nothing GUI, nothing platform-specific.
# GUI apps live in darwin/common.nix (Homebrew casks); mac-only home config in
# home/darwin.nix; desktop/Wayland config stays frozen in hosts/laptop.
{
  config,
  pkgs,
  lib,
  ...
}: {
  home.stateVersion = "26.11";

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # rustup/uv install here; keep default locations (existing toolchains live there).
  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.shellAliases = {
    ls = "eza";
    la = "eza -a";
    ll = "eza -la";
    cp = "cp -iv";
    mv = "mv -iv";
    mkdir = "mkdir -pv";
    ed = "$EDITOR";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      append = true;
    };
    # zsh-vi-mode may clobber fzf's Ctrl-R binding on init; if that bites, rebind
    # inside a zvm_after_init hook.
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  # starship/zoxide/fzf/direnv auto-integrate into zsh when enabled.
  programs.starship.enable = true;
  # zoxide replaces cd: real paths still work, plus frecency jumps by name.
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
  programs.fzf.enable = true;
  programs.btop.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    # macOS still writes .DS_Store on local volumes (no OS toggle for that);
    # keep them out of every repo globally.
    ignores = [".DS_Store" "**/.claude/settings.local.json"];
    settings = {
      user.name = "Luis Wirth";
      user.email = "lwirth2000@gmail.com";
      init.defaultBranch = "main";
      push.default = "current";
      pull.ff = "only";
    };
    signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      aliases.co = "pr checkout";
    };
  };
  programs.jujutsu.enable = true;

  # SQLite shell history with fuzzy search, synced across Mac and the server.
  programs.atuin.enable = true;

  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "euler" = {
        HostName = "euler.ethz.ch";
        User = "luwirth";
        ForwardAgent = true;
      };
      # lightning.ai instances are ephemeral (IPs churn), so host-key checking
      # is intentionally disabled.
      "ssh.lightning.ai" = {
        IdentityFile = "~/.ssh/lightning_rsa";
        IdentitiesOnly = true;
        ServerAliveInterval = 15;
        ServerAliveCountMax = 4;
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    };
  };

  # gpg-agent provides SSH support (no separate ssh-agent; they conflict on
  # SSH_AUTH_SOCK). systemd-backed, so Linux only; macOS uses its own launchd
  # ssh-agent, with pinentry_mac configured in home/darwin.nix.
  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = false;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    ignores = ["build/" ".direnv/"];
    settings = {
      theme = "ayu_mirage";
      editor = {
        auto-pairs = false;
        line-number = "relative";
        whitespace.render.newline = "all";
        indent-guides = {
          render = true;
          character = "┊";
          skip-levels = 0;
        };
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
        gutters = ["diagnostics" "spacer" "line-numbers" "spacer"];
        statusline = {
          left = ["mode" "spinner" "version-control" "read-only-indicator" "file-name" "file-modification-indicator"];
          center = ["diagnostics" "workspace-diagnostics"];
          right = ["selections" "primary-selection-length" "file-encoding" "file-line-ending" "position" "position-percentage" "file-type"];
        };
      };
      keys.normal = {
        H = "goto_line_start";
        L = "goto_line_end_newline";
      };
      keys.select = {
        H = "goto_line_start";
        L = "goto_line_end_newline";
      };
    };
    languages = {
      language-server = {
        rust-analyzer.config.check.command = "clippy";
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        pyright = {
          command = "pyright-langserver";
          args = ["--stdio"];
        };
      };
      language = [
        {
          name = "python";
          language-servers = ["ruff" "pyright"];
          auto-format = true;
        }
      ];
    };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      default_mode = "locked";
      default_layout = "compact";
      pane_frames = false;
      session_serialization = false;
      theme = "catppuccin-macchiato";
      keybinds.locked = {
        "bind \"Ctrl g\"".SwitchToMode = ["Normal"];
        "bind \"Alt h\"".MoveFocusOrTab = ["Left"];
        "bind \"Alt l\"".MoveFocusOrTab = ["Right"];
        "bind \"Alt j\"".MoveFocus = ["Down"];
        "bind \"Alt k\"".MoveFocus = ["Up"];
      };
    };
  };

  programs.yazi.enable = true;

  programs.man.generateCaches = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # nix
    alejandra
    nil
    nix-output-monitor

    # cli (migrated off Homebrew)
    bat
    eza
    fd
    sd
    dust
    ripgrep
    tealdeer
    ouch
    kondo
    tokei
    onefetch
    just
    hyperfine
    jq
    tree
    wget
    curl
    zip
    unzip
    unar
    moreutils
    magic-wormhole
    openconnect

    # media
    ffmpeg
    imagemagick
    yt-dlp

    # dev
    uv
    ruff
    pyright
    typst
    tinymist
    neovim
    claude-code

    # fonts
    nerd-fonts.fira-code
    fira-math
    newcomputermodern
    noto-fonts
    noto-fonts-color-emoji
  ];

  programs.home-manager.enable = true;
}
