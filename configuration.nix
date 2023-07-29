{ inputs, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      builders-use-substitutes = true;
      substituters = [
        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];
    };
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 31d";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
    kernelPackages = pkgs.linuxPackages_latest;

    # potential amdgpu error workaround
    kernelParams = [ "amdgpu.noretry=0" "amdgpu.dcdebugmask=0x4" "amdgpu.vm_update_mode=3" ];
  };

  systemd.services.ryzenadj = {
    description = "Set Ryzen CPU to maximum performance";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.ryzenadj}/bin/ryzenadj --max-performance";
      User = "root";
      Group = "root";
    };
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  users.users.luis = {
    isNormalUser = true;
    description = "Luis Wirth";
    extraGroups = [ "wheel" "input" "video" "audio" "networkmanager" "libvirtd" ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = [ "/share/fish" ];
  environment.shells = with pkgs; [ fish ];

  networking = {
    hostName = "lwirth-tp";
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  services.printing.enable = true;

  services.fwupd.enable = true;

  # caps as escape in tty
  services.xserver.xkbOptions = "caps:escape"; 
  console.useXkbConfig = true; 
  
  # power saving
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };
  # this option used to make my Thinkpad Z16 freeze after resuming from suspend
  #services.tlp.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };

  programs.light.enable = true;

  # virtualization
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.udev.extraRules = ''
    # rp2040
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

    # picoprobe
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0004", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    virt-manager
    docker

    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;

  programs.mtr.enable = true;
  services.pcscd.enable = true;
  services.gvfs.enable = true;
  services.avahi.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };


  # fix swaylock issue
  security.pam.services.swaylock = {};

  security.rtkit.enable = true;
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wants = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

