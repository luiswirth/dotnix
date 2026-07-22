# Baseline NixOS config shared by any NixOS host (currently the dev server).
# Nix settings, user, locale, shell. No desktop, no hardware specifics.
{
  pkgs,
  user,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
  # GC is handled by nh clean (below), not nix.gc.automatic.
  programs.nh = {
    enable = true;
    flake = "/home/${user}/dev/dotnix";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    isNormalUser = true;
    description = "Luis Wirth";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMaKCRCE1/4DkpMmcp02vu8V/YeOKU1pVnesEtuAVOIk lwirth2000@gmail.com"
    ];
  };
}
