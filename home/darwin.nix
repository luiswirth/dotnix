# Mac-only Home Manager config. Imported only by the macbook host.
{
  config,
  pkgs,
  ...
}: {
  # nix-darwin has no programs.nh; drive it from Home Manager instead.
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/dev/dotnix";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  # Keep Homebrew on PATH in login shells (nix-darwin's homebrew module does not
  # do this itself). Without it, brew disappears once HM owns the zsh files.
  programs.zsh.profileExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  # macOS-only SSH: store key passphrases in the Keychain, and the ETH VLSI
  # course hosts (VNC over forwarded ports, via the EE login gateway).
  programs.ssh.settings = {
    "*".UseKeychain = "yes";
    "vlsi2" = {
      HostName = "tardis-a34.ee.ethz.ch";
      User = "vlsi2_19fs26";
      ForwardAgent = true;
      LocalForward = ["5905 localhost:5905"];
    };
    "vlsi2-gw" = {
      HostName = "login.ee.ethz.ch";
      User = "vlsi2_19fs26";
      ForwardAgent = true;
    };
    "vlsi2-remote" = {
      HostName = "tardis-a34.ee.ethz.ch";
      User = "vlsi2_19fs26";
      ForwardAgent = true;
      ProxyJump = "vlsi2-gw";
      LocalForward = ["5905 localhost:5905"];
    };
  };

  # nixpkgs' ghostty doesn't build on darwin; install the binary via Homebrew
  # cask (darwin/common.nix) and let Home Manager own the config.
  programs.ghostty = {
    enable = true;
    package = null;
    installBatSyntax = false;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 14;
      background-opacity = 0.92;
      cursor-style = "bar";
    };
  };
}
