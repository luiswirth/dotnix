{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
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
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  users.users.luis = {
    isNormalUser = true;
    description = "Luis Wirth";
    extraGroups = [ "wheel" "input" "video" "audio" "networkmanager" "libvirtd" ];
    packages = with pkgs; [ ];
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

  # power saving
  # one of these two options makes my Thinkpad Z16 freeze after resuming from suspend
  #services.tlp.enable = true;
  #services.upower = {
    #enable = true;
    #criticalPowerAction = "Hibernate";
  #};

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  programs.light.enable = true;

  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
  };

  services.udev.extraRules = ''
    # rp2040
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

    # picoprobe
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0004", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    virt-manager

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

