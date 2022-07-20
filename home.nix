{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    kitty
    chromium
    brave
    xournalpp
    zathura
    imv
    spotify
    ffmpeg_5

    starship
    nnn
    btop
    trash-cli
    rmtrash
    tealdeer
  ];

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
        "image/*" = "imv-folder.desktop";
        "text/plain" = "nvim.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        #"inode/directory" = "nnn.desktop";
        "video/*" = "ffplay.desktop";
      };
    };

    configFile = {
      "zsh".source = ./config/zsh;
      "git/config".source = ./config/git;
      "nvim".source = ./config/nvim;
      "kitty/kitty.conf".source = ./config/kitty.conf;
      "zellij/config.yaml".source = ./config/zellij.yaml;
      "sway/config".source = ./config/sway;
      "kanshi/config".source = ./config/kanshi;
      "waybar".source = ./config/waybar;
      "zathura/zathurarc".source = ./config/zathura;
    };
  };


  #home.file.".config/git/config".source = ./config/git;

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
