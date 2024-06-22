{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  programs.nh = {
    enable = true;
    #clean.enable = true;
    #clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/luis/.dotnix";
  };

  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["quiet"];
    initrd = {
      systemd.enable = true;
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
    plymouth.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [wireless-regdb];

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "lwirth-tp";
    networkmanager.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  users.groups.stdgroup = {
    name = "standard";
    members = ["luis" "guest"];
  };
  users.users.luis = {
    description = "Luis Wirth";
    isNormalUser = true;
    extraGroups = ["wheel" "input" "video" "audio" "networkmanager" "libvirtd" "docker"];
  };
  users.users.guest = {
    description = "Guest";
    isNormalUser = true;
    extraGroups = [];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = ["/share/fish"];
  environment.shells = with pkgs; [fish];

  # caps as escape in tty
  services.xserver.xkb.options = "caps:escape";
  console.useXkbConfig = true;

  services.fwupd.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "bredr";
      };
    };
  };
  hardware.logitech.wireless.enable = true;
  services.printing.enable = true;

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk

      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  # power saving
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };

  programs.light.enable = true;

  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;

  documentation.dev.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.mtr.enable = true;
  services.pcscd.enable = true;
  services.gvfs.enable = true;

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
    #extraConfig = "AuthenticationMethods \"publickey,password\"";
  };
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment.enable = true;
  };

  services.dbus.packages = with pkgs; [
    gcr
    swaynotificationcenter
  ];

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [22 42069];
  };

  security.pam.services.hyprlock = {};

  programs.droidcam.enable = true;
  services.usbmuxd.enable = true;

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # kmsgrab without sudo
  security.wrappers = {
    ffmpeg = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin=ep";
      source = "${pkgs.ffmpeg}/bin/ffmpeg";
    };
  };

  systemd.packages = with pkgs; [swaynotificationcenter];

  systemd.services.lock-on-sleep = {
    description = "Lock on sleep";
    before = ["sleep.target"];
    wantedBy = ["sleep.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/loginctl lock-sessions";
    };
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wants = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # can be removed after https://github.com/NixOS/nixpkgs/pull/318759 is merged
  xdg.portal.enable = true;

  stylix = {
    enable = true;
    image = "${pkgs.hyprland}/share/hyprland/wall0.png";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";

    cursor = {
      size = 24;
      package = pkgs.apple-cursor;
      name = "macOS-Monterey";
    };

    fonts = {
      sizes = {
        applications = 10;
        terminal = 14;
        desktop = 10;
        popups = 10;
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    targets.gnome.enable = true;
  };

  services.udev.extraRules = ''
    # rp2040
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

    # picoprobe
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0004", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    virtiofsd

    man-pages
    man-pages-posix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
