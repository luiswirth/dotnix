{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.sessionVariables = let
    cacheDir = "${config.home.homeDirectory}/.cache";
    #configDir = "${config.home.homeDirectory}/.config";
    dataDir = "${config.home.homeDirectory}/.local/share";
  in {
    TERMINAL = "alacritty";
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "firefox";
    TASKMGR = "btop";
    READER = "zathura";
    FILEMGR = "nnn";

    # clean home
    RUSTUP_HOME = "${dataDir}/rustup";
    CARGO_HOME = "${dataDir}/cargo";
    CARGO_TARGET_DIR = "${cacheDir}/target";

    # hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";

    GTK_THEME = "Adwaita:dark";
  };

  home.shellAliases = {
    ls = "eza";
    la = "eza -a";
    ll = "eza -la";
    rm = "rm -v";
    cp = "cp -iv";
    mv = "mv -iv";
    mkdir = "mkdir -pv";
    ed = "$EDITOR";
  };

  home.sessionPath = [
    "$HOME/script"
    "$CARGO_HOME/bin"
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = "fish_vi_key_bindings
      set --erase fish_greeting";
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.man.generateCaches = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
    };
  };
  services.ssh-agent.enable = true;

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./config/hyprland.conf;
    plugins = [
      #pkgs.hyprlandPlugins.hy3
      inputs.hy3.packages.${pkgs.system}.hy3
      inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
    ];
  };
  programs.waybar.enable = true;
  programs.wofi.enable = true;

  # theming
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      monospace-font-name = "DejaVu Sans Mono";
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    font.package = pkgs.ubuntu_font_family;
    font.name = "Ubuntu";
    #theme.package = ...
    theme.name = "Adwaita-dark";
    iconTheme.package = pkgs.gnome.adwaita-icon-theme;
    iconTheme.name = "Adwaita";

    gtk3.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    gtk4.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };

  home.pointerCursor = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    alejandra

    bitwarden-desktop
    bitwarden-cli

    openssl
    cacert
    xdg-user-dirs
    xdg-utils

    trash-cli
    moreutils
    tree
    zip
    unzip
    wget
    curl
    lshw
    usbutils
    pciutils
    psmisc
    nmap

    helix
    neovim
    git
    github-cli
    zellij
    nnn

    openconnect
    sshfs
    gnuplot
    tmpmail
    pass
    restic
    ffmpeg_5-full

    eza
    bat
    fd
    sd
    du-dust
    ripgrep
    ripgrep-all
    procs
    pueue
    btop
    tealdeer
    starship
    ouch
    diskonaut
    kondo
    tokei

    hyprlock
    hypridle
    brightnessctl
    wl-clipboard
    libnotify
    swaynotificationcenter
    kanshi
    wl-mirror
    waypipe
    grim
    slurp
    playerctl
    pamixer
    pavucontrol
    pulsemixer

    alacritty
    chromium
    firefox

    spotify

    imv
    zathura
    xournalpp
    obs-studio
    vlc
    obsidian
    discord
    zoom-us
    slack
    element-desktop
    signal-desktop
    prismlauncher
    gimp
    inkscape

    clang
    rustup

    pipenv
    elan

    nil

    pandoc
    typst
    typstfmt
    typst-lsp

    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    libertine
    liberation_ttf
    ubuntu_font_family
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  systemd.user.services = {
    pueued = {
      Unit.Description = "pueued - pueue daemon";
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStart = "${pkgs.pueue}/bin/pueued -v";
        Restart = "on-failure";
      };
    };
  };

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
        "application/pdf" = "org.pwmt.zathura.desktop";
        "image/*" = "imv.desktop";
        "video/*" = "vlc.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "text/plain" = "helix.desktop";
      };
      associations.added = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };

    configFile = {
      "git/config".source = ./config/git;
      "helix/config.toml".source = ./config/helix/config.toml;
      "helix/languages.toml".source = ./config/helix/languages.toml;
      "zellij/config.kdl".source = ./config/zellij.kdl;

      "hypr/hyprlock.conf".source = ./config/hyprlock.conf;
      "hypr/hypridle.conf".source = ./config/hypridle.conf;
      "waybar".source = ./config/waybar;
      "kanshi/config".source = ./config/kanshi;
      "wofi/config".source = ./config/wofi/config;
      "wofi/style.css".source = ./config/wofi/style.css;

      "zathura/zathurarc".source = ./config/zathura;
    };
  };

  home.file."script".source = ./script;

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
