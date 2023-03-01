{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
  ];

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 31d";
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # blacklist igc (intel ethernet driver) to avoid problems with thinkpad dock
  boot.blacklistedKernelModules = [ "igc" ];

  networking = {
    hostName = "lwirth-tp";
    wireless.iwd.enable = true;
  };

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  
  hardware.opengl.enable = true;

  users.users.luis = {
    isNormalUser = true;
    extraGroups = [ "adm" "ftp" "games" "http" "log" "rfkill" "sys" "uucp" "scanner" "kvm" "storage" "wheel" "input" "video" "audio" "dialout" "libvirtd" ];
    packages = with pkgs; [ ];
  };
  security.sudo.wheelNeedsPassword = false;
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
  
  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.udev.extraRules = ''
    # rp2040
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE:="0666"

    # picoprobe
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0004", MODE="660", GROUP="plugdev", TAG+="uaccess"
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
  system.stateVersion = "22.05"; # Did you read the comment?
}

