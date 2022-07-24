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
      RUSTUP_HOME = "${dataDir}/rustup";
      CARGO_HOME = "${dataDir}/cargo";
      CARGO_TARGET_DIR = "${cacheDir}/target";
      JAVA_HOME = "${dataDir}/java";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configDir}/java";
      GOPATH = "${dataDir}/go";
      CUDA_CACHE_PATH = "${cacheDir}/nv";
      PASSWORD_STORE_DIR = "${dataDir}/password-store";
      GNUPGHOME = "${dataDir}/gnupg";
    };

  home.shellAliases = {
    sudo = "sudo ";
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

  programs.nix-index.enable = true;

  programs.helix = {
    enable = true;
    # move config here
  };

  home.packages = with pkgs; [
    neovim
    zellij
    wget
    curl
    git
    github-cli
    exa
    fd
    sd
    procs
    ripgrep
    ripgrep-all

    nnn
    btop
    trash-cli
    rmtrash
    tealdeer
    diskonaut

    comma

    kitty
    chromium
    brave
    xournalpp
    zathura
    imv
    spotify
    ffmpeg_5-full
    obs-studio
    signal-desktop

    tectonic

    xdg-user-dirs
    xdg-utils
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

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "imv-folder.desktop";
        "image/jpeg" = "imv-folder.desktop";
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
