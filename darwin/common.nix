# nix-darwin system config for the MacBook (Apple Silicon).
# Determinate Nix owns the daemon (nix.enable = false); GUI apps come from
# Homebrew casks; AeroSpace and the macOS defaults are declared here.
{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  system.stateVersion = 6;
  system.primaryUser = user;

  nixpkgs.config.allowUnfree = true;

  # Determinate Nix manages Nix; stand down and hand it our tracked settings.
  nix.enable = false;
  environment.etc."nix/nix.custom.conf".source = ./nix.custom.conf;
  # nh lives in home/darwin.nix (nix-darwin has no programs.nh module).

  users.users.${user}.home = "/Users/${user}";
  # Login shell stays the system /bin/zsh; Home Manager owns ~/.zshrc.
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-math
    newcomputermodern
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none": don't remove brew packages installed outside this file yet.
      # Tighten to "uninstall"/"zap" once the Brewfile is authoritative.
      cleanup = "none";
    };
    casks = [
      "google-chrome"
      "signal"
      "whatsapp"
      "spotify"
      "obsidian"
      # Claude Desktop self-updates; left out so brew doesn't fight it.
      "ghostty"
    ];
    # App Store-only apps (need `mas` + Apple ID). Enable later if wanted:
    # masApps = { Goodnotes = 1444383602; };
  };

  # AeroSpace: i3-style tiling WM. Installed from nixpkgs and run as a launchd
  # agent by this module; no SIP disable, no cask needed.
  services.aerospace = {
    enable = true;
    settings = {
      # Autostart is handled by this module's launchd agent, not by AeroSpace.
      start-at-login = false;
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.right = 8;
        outer.top = 8;
        outer.bottom = 8;
      };
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-f = "fullscreen";
        alt-enter = "exec-and-forget open -na Ghostty";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Reconstructed from the machine's current values so activation is a no-op for
  # settings already chosen by hand. Two keys were previously unset and are
  # deliberate additions (marked): fast key repeat and the Finder path bar.
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      # additions (were unset): fast key repeat for vim/helix
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      # writing/coding: no smart quotes or dashes to mangle source
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      # European locale conventions
      AppleICUForce24HourTime = true;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      # keyboard-driven: tab through every control in dialogs
      AppleKeyboardUIMode = 3;
      # expand save/print panels by default
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.0; # instant reveal
      tilesize = 49;
      mru-spaces = false;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
      ShowPathbar = true; # addition (was unset)
    };
    screencapture.location = "/Users/${user}/Pictures/screenshots";

    # No typed module: written via the raw-domain escape hatch.
    CustomUserPreferences = {
      # kill .DS_Store on network and USB volumes (no toggle exists for local)
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      # faster window resize animation
      NSGlobalDomain.NSWindowResizeTime = 0.001;
    };
  };
}
