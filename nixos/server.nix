# Headless dev-server role: remote access hardening + tailnet.
# The shell/editor/zellij world comes from home/core.nix; nothing desktop here.
{
  pkgs,
  user,
  ...
}: {
  # Headless: closing the lid must never suspend the machine.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # Blank the console after 5 min idle so the panel powers off lid-closed.
  boot.kernelParams = ["consoleblank=300"];

  # caps-lock as escape at the console.
  console.keyMap = pkgs.writeText "caps-to-esc.map" ''
    include "${pkgs.kbd}/share/keymaps/i386/qwerty/us.map.gz"
    keycode 58 = Escape
  '';

  # A long-running agent session must outlive both the SSH connection and the
  # machine. zellij handles the first; these two handle the second. Lingering
  # starts the user manager at boot, so the session exists before anyone logs
  # in -- without it the unit below would only run after a first login.
  users.users.${user}.linger = true;

  systemd.user.services.zellij-main = {
    description = "Persistent zellij session for long-running agent work";
    wantedBy = ["default.target"];
    serviceConfig = {
      # The command creates the session and exits; the zellij server it spawns
      # daemonizes and is not tracked by this unit. RemainAfterExit keeps the
      # unit "active" so it isn't re-run on every default.target reach.
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.zellij}/bin/zellij attach --create-background main";
    };
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
