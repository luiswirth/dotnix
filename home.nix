{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.packages = with pkgs; [
    kitty
    chromium
    brave
    xournalpp
    zathura
    imv
    spotify

    starship
    nnn
    btop
    trash-cli
    rmtrash
    tealdeer

    xdg-user-dirs
    xdg-utils
    xdg-launch
  ];  
  
  xdg.configFile."zsh".source = ./config/zsh;
  xdg.configFile."git/config".source = ./config/git;
  xdg.configFile."nvim".source = ./config/nvim;
  xdg.configFile."kitty/kitty.conf".source = ./config/kitty.conf;
  xdg.configFile."zellij/config.yaml".source = ./config/zellij.yaml;
  xdg.configFile."sway/config".source = ./config/sway;
  xdg.configFile."kanshi/config".source = ./config/kanshi;
  xdg.configFile."waybar".source = ./config/waybar;
  xdg.configFile."zathura/zathurarc".source = ./config/zathura;


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
