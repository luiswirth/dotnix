# Headless dev-server role: remote access hardening + tailnet.
# The shell/editor/zellij world comes from home/core.nix; nothing desktop here.
{...}: {
  # Headless: closing the lid must never suspend the machine.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment.enable = true;
  };

  # Tailnet: reach the box by a stable name from anywhere, no public exposure.
  services.tailscale.enable = true;

  # Track the committed config from GitHub weekly. Rebuilds but never reboots
  # on its own (won't interrupt long tasks); a new kernel applies next reboot.
  # Requires the repo pushed to github:luiswirth/dotnix (accessible to the box).
  system.autoUpgrade = {
    enable = true;
    flake = "github:luiswirth/dotnix";
    dates = "weekly";
    randomizedDelaySec = "45min";
    allowReboot = false;
  };

  networking.firewall = {
    enable = true;
    # Full access over the tailnet; SSH also reachable on the LAN for bootstrap.
    trustedInterfaces = ["tailscale0"];
    allowedTCPPorts = [22];
  };
}
