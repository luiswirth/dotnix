{ pkgs, ... }:
{
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  programs.nushell = {
    enable = true;
    configFile.source = ./config/nushell/config.nu;
    envFile.source = ./config/nushell/env.nu;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
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

    #kitty
    alacritty
    firefox
    brave
    chromium
    imv
    zathura
    spotify
    xournalpp
    obs-studio
    obsidian

    signal-desktop
    discord
    zoom-us

    tectonic
    ffmpeg_5-full

    xdg-user-dirs
    xdg-utils

    pass

    prismlauncher

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
        "image/png" = "imv-folder.desktop";
        "image/jpeg" = "imv-folder.desktop";
        "text/plain" = "nvim.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "video/*" = "ffplay.desktop";
      };
    };

    configFile = {
      "git/config".source = ./config/git;
      "nvim".source = ./config/nvim;
      "helix".source = ./config/helix;
      "kitty/kitty.conf".source = ./config/kitty.conf;
      "zellij/config.kdl".source = ./config/zellij.kdl;
      "sway/config".source = ./config/sway;
      "kanshi/config".source = ./config/kanshi;
      "waybar".source = ./config/waybar;
      "zathura/zathurarc".source = ./config/zathura;
      "starship.toml".source = ./config/starship.toml;
    };
  };

  home.file."script".source = ./script;
  #home.file."file.foo".source = config.lib.file.mkOutOfStoreSymlink ./path/to/file/to/link;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
