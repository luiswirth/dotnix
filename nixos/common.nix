# Baseline NixOS config shared by any NixOS host (currently the dev server).
# Nix settings, user, locale, shell. No desktop, no hardware specifics.
{
  pkgs,
  user,
  flakePath,
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
    flake = flakePath;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  # Ghostty sets TERM=xterm-ghostty; ship its terminfo so SSH sessions from the
  # Mac don't error on a missing terminal definition.
  environment.systemPackages = [pkgs.ghostty.terminfo];

  programs.zsh.enable = true;

  # NixOS ships no /lib64/ld-linux-x86-64.so.2, so prebuilt generic-Linux
  # binaries fail at the loader (stub-ld prints the explanation). nix-ld puts a
  # real loader there backed by these libraries. Needed by anything installed
  # outside nix -- the Claude Code native installer, rustup, prebuilt wheels.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [stdenv.cc.cc.lib zlib openssl curl];
  };

  # Claude Code policy. Managed settings is the one config file the CLI never
  # writes, so nix can own it outright; ~/.claude/settings.json stays imperative
  # because the CLI rewrites it (plugin toggles, /config). Managed rules merge
  # with the other scopes rather than replacing them.
  environment.etc."claude-code/managed-settings.json".source = ../claude/managed-settings.json;

  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    isNormalUser = true;
    description = "Luis Wirth";
    extraGroups = ["wheel" "networkmanager"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMaKCRCE1/4DkpMmcp02vu8V/YeOKU1pVnesEtuAVOIk lwirth2000@gmail.com"
    ];
  };
}
