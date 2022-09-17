# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./sway.nix
  ];

  # periodically collect garbage automatically
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 31d";
    };
  };

  # protect nix shell against garbage collection
  #nix.extraOptions = ''
  #  keep-outputs = true
  #  keep-derivations = true
  #'';

  # use flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # blacklist igc (intel ethernet driver) to avoid problems with thinkpad dock
  boot.blacklistedKernelModules = [ "igc" ];

  networking.hostName = "lwirth-tp";
  networking.wireless.iwd.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true;

  users.users.luis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "dialout" ];
    packages = with pkgs; [ ];
  };
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = [ "/share/fish" ];
  environment.shells = with pkgs; [ fish ];

  # allow setting brightness with function keys
  programs.light.enable = true;

  # power saving
  services.tlp.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  nixpkgs.config.allowUnfree = true;

  services.udev.extraRules = ''
    # Suspend the system when battery level drops to 5% or lower
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+=systemctl hibernate"

    # rp2040
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

    # picoprobe
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0004", MODE="660", GROUP="plugdev", TAG+="uaccess"
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  services.openssh.enable = true;
  programs.mtr.enable = true;
  services.pcscd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

