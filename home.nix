{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.sessionVariables = {
    TERMINAL = "kitty";
    SHELL = "fish";
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "brave";
    TASKMGR = "btop";
    READER = "zathura";
    FILE = "nnn";
    WM = "sway";

    # clean home
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    CARGO_TARGET_DIR = "$XDG_CACHE_HOME/target";
    JAVA_HOME = "$XDG_DATA_HOME/java";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java";
    GOPATH = "$XDG_DATA_HOME/go";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    WAKATIME_HOME = "$XDG_CONFIG_HOME/wakatime";
    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
  };

  home.shellAliases = {
    sudo = "sudo ";
    ls = "exa";
    la = "exa -a";
    ll = "exa -la";
    rm = "rmtrash";
    rmdir = "rmdirtrash";
    realrm = "rm -v";
    cp = "cp -iv";
    mv = "mv -iv";
    mkdir = "mkdir -pv";
    ed = "$EDITOR";
    sk = "sk --preview='bat {} --color=always'";
    vim = "nvim";
    vi = "nvim";
    yta = "yt -x -f bestaudio/best -i";
    g = "git";
    ssh = "kitty +kitten ssh";
    zellij = "zellij --layout compact";
  };

  home.sessionPath = [
    "$HOME/script"
    "$CARGO_HOME/bin"
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = "fish_vi_key_bindings";
  };

  programs.man.generateCaches = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
  };

  home.packages = with pkgs; [
    kitty
    chromium
    brave
    xournalpp
    zathura
    imv
    spotify
    ffmpeg_5

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
