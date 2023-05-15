{ config, pkgs, ... }:
{
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.sessionVariables =
    let
      cacheDir = "${config.home.homeDirectory}/.cache";
      configDir = "${config.home.homeDirectory}/.config";
      dataDir = "${config.home.homeDirectory}/.local/share";
    in
    {
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
    };


  home.shellAliases = {
    ls = "exa";
    la = "exa -a";
    ll = "exa -la";
    rm = "rm -v";
    ash = "rmtrash";
    ashdir = "rmdirtrash";
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
    interactiveShellInit =
      "fish_vi_key_bindings
      set --erase fish_greeting";

  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
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
  };
  programs.ssh.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    openssl
    cacert
    pinentry-gtk2

    helix
    neovim
    zellij
    pueue
    git
    github-cli
    nnn
    btop
    sshfs

    lshw
    pciutils

    exa
    bat
    fd
    sd
    du-dust
    ripgrep
    ripgrep-all
    procs
    gitui
    ouch
    diskonaut
    tealdeer
    starship
    wget
    curl
    delta
    kondo
    gnuplot
    tmpmail

    alacritty
    firefox
    imv
    zathura
    spotify
    xournalpp
    obs-studio
    ffmpeg_5-full

    obsidian

    discord
    element-desktop
    signal-desktop

    tectonic
    typst
    typst-lsp

    prismlauncher

    xdg-user-dirs
    xdg-utils

    pass
    restic

    # fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  systemd.user.services = {
    pueued = {
      Unit.Description = "pueued - pueue daemon";
      Install.WantedBy = [ "default.target" ];
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

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "image/png" = "imv-folder.desktop";
        "image/jpeg" = "imv-folder.desktop";
        "text/plain" = "helix.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "video/*" = "ffplay.desktop";
      };
    };

    configFile = {
      "git/config".source = ./config/git;
      "nvim".source = ./config/nvim;
      "helix/config.toml".source = ./config/helix/config.toml;
      "helix/languages.toml".source = ./config/helix/languages.toml;
      "kitty/kitty.conf".source = ./config/kitty.conf;
      "zellij/config.kdl".source = ./config/zellij.kdl;
      "sway/config".source = ./config/sway;
      "kanshi/config".source = ./config/kanshi;
      "waybar".source = ./config/waybar;
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
