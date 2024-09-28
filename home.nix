{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.sessionVariables = let
    cacheDir = "${config.home.homeDirectory}/.cache";
    dataDir = "${config.home.homeDirectory}/.local/share";
  in {
    TERMINAL = "wezterm";
    EDITOR = "hx";
    FILEMGR = "nnn";

    # clean home
    RUSTUP_HOME = "${dataDir}/rustup";
    CARGO_HOME = "${dataDir}/cargo";
    CARGO_TARGET_DIR = "${cacheDir}/target";

    # apps should use wayland
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    T_QPA_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.shellAliases = {
    ls = "eza";
    la = "eza -a";
    ll = "eza -la";
    tr = "trash-put -v";
    rm = "rm -v";
    cp = "cp -iv";
    mv = "mv -iv";
    mkdir = "mkdir -pv";
    ed = "$EDITOR";
  };

  home.sessionPath = [
    "$CARGO_HOME/bin"
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = "fish_vi_key_bindings
      set fish_greeting
      jj util completion fish | source";
    functions = {
      bwu = "set -xU BW_SESSION (bw unlock --raw)";
    };
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.man.generateCaches = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Luis Wirth";
    userEmail = "lwirth2000@gmail.com";
    signing.key = "/home/luis/.ssh/id_ed25519.pub";
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      pull.ff = "only";
      #commit.gpgsign = true;
      #gpg.format = "ssh";
    };
  };
  programs.gh.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    matchBlocks = {
      "euler.ethz.ch" = {
        hostname = "euler";
        user = "luwirth";
        forwardAgent = true;
      };
      "slab1.ethz.ch" = {
        hostname = "slab1";
        user = "luwirth";
        forwardAgent = true;
      };
    };
  };
  services.ssh-agent.enable = true;

  programs.btop.enable = true;

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [];
    extraConfig = builtins.readFile ./config/hyprland.conf;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ./config/hyprlock.conf;
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        before_sleep_cmd = "";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 1700;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 1700;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 1800;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1850;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 3600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile.name = "laptop";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 2.0;
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "Samsung Electric Company U28H75x HTPJ700579";
            #criteria = "DP-8";
            position = "0,0";
            scale = 1.5;
            mode = "3840x2160@60.00Hz";
          }
          #{
          #  criteria = "DP-9";
          #  position = "-2560,0";
          #  scale = 1.5;
          #  mode = "3840x2160@60.00Hz";
          #}
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
    ];
  };

  stylix.targets = {
    helix.enable = false;
    zellij.enable = false;
    hyprland.enable = false;
    wofi.enable = false;
  };

  programs.waybar.enable = true;
  programs.wofi = {
    enable = true;
    settings = {
      mode = "drun";
      allow_images = true;
    };
    style = builtins.readFile ./config/wofi/style.css;
  };

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor-keephue = "true";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.obs-studio = {
    enable = true;
    #plugins = with pkgs; [obs-studio-plugins.droidcam-obs];
  };

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = builtins.readFile ./config/wezterm.lua;
  };
  programs.alacritty.enable = true;

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
          left = [
            "mode"
            "spinner"
            "version-control"
            "read-only-indicator"
            "file-name"
            "file-modification-indicator"
          ];
          center = ["diagnostics" "workspace-diagnostics"];
          right = [
            "selections"
            "primary-selection-length"
            "file-encoding"
            "file-line-ending"
            "position"
            "position-percentage"
            "file-type"
          ];
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
      language-server.rust-analyzer.config = {
        check.command = "clippy";
      };
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      default_mode = "locked";
      default_layout = "compact";
      pane_frames = false;
      session_serialization = false;
      theme = "catppuccin-macchiato";
      keybinds = {
        locked = {
          "bind \"Ctrl g\"" = {
            SwitchToMode = ["Normal"];
          };
          "bind \"Alt h\"" = {
            MoveFocusOrTab = ["Left"];
          };
          "bind \"Alt l\"" = {
            MoveFocusOrTab = ["Right"];
          };
          "bind \"Alt j\"" = {
            MoveFocus = ["Down"];
          };
          "bind \"Alt k\"" = {
            MoveFocus = ["Up"];
          };
        };
      };
    };
  };
  programs.yazi.enable = true;
  programs.jujutsu.enable = true;

  # USB automount
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  home.packages = with pkgs;
    [
      alejandra

      cacert
      xdg-user-dirs
      xdg-utils

      trash-cli
      moreutils
      tree
      zip
      unzip
      unar
      jq
      wget
      curl
      lshw
      usbutils
      pciutils
      psmisc
      nmap

      sshpass
      sshfs
      openconnect

      openssl
      #bitwarden-desktop
      bitwarden-cli
      restic

      gnuplot
      tmpmail
      ffmpeg-full
      ffmpegthumbnailer

      eza
      bat
      fd
      sd
      du-dust
      ripgrep
      ripgrep-all
      procs
      #pueue
      tealdeer
      starship
      ouch
      diskonaut
      kondo
      tokei
      onefetch

      kanshi
      brightnessctl
      wl-clipboard
      libnotify
      swaynotificationcenter
      wl-mirror
      waypipe
      grim
      slurp
      playerctl
      pamixer
      pavucontrol
      pulsemixer

      firefox
      google-chrome
      spotify
      oculante

      feh
      xournalpp
      vlc
      audacity
      obsidian
      discord
      zoom-us
      slack
      element-desktop
      signal-desktop
      prismlauncher
      gimp
      inkscape
      zed-editor
      okular

      clang
      rustup

      pipenv
      #elan

      nil

      pandoc
      typst
      typstfmt
      #typst-lsp

      anki-bin

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      libertine
      liberation_ttf
      ubuntu_font_family
      dejavu_fonts
      fira-code
      fira-code-symbols
      newcomputermodern
      fira-math
      font-awesome
      (nerdfonts.override {fonts = ["FiraCode"];})
    ]
    ++ (
      map
      (scriptName:
        pkgs.writeShellScriptBin
        scriptName
        (builtins.readFile (./script + "/${scriptName}")))
      (builtins.attrNames
        (builtins.readDir ./script))
    );

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "$HOME/desktop";
      documents = "$HOME/docs";
      download = "$HOME/dl";
      music = "$HOME/media/music";
      pictures = "$HOME/media/img";
      publicShare = "$HOME/tmp/publicshare";
      templates = "$HOME/tmp/templates";
      videos = "$HOME/media/vid";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.kde.okular.desktop";
        "image/*" = "oculante.desktop";
        "video/*" = "vlc.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
      associations.added = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };

    configFile = {
      "waybar".source = ./config/waybar;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
