# Dev server host: the repurposed ThinkPad, headless.
# Reuses the machine's generated hardware config; adds boot + networking.
{...}: {
  imports = [./laptop/hardware.nix];

  networking.hostName = "lwirth-server";
  # WiFi-only machine (mt7921e); NetworkManager handles association.
  networking.networkmanager.enable = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  # systemd-initrd is required for TPM2-based LUKS unlock.
  boot.initrd.systemd.enable = true;
  # Auto-unlock the encrypted root via the TPM so the box boots unattended
  # (survives power loss with no keyboard). Enroll once on the machine:
  #   systemd-cryptenroll --tpm2-device=auto \
  #     /dev/disk/by-uuid/5bed133c-e06f-42ec-aa69-19a763197b8f
  boot.initrd.luks.devices."luks-5bed133c-e06f-42ec-aa69-19a763197b8f".crypttabExtraOpts = ["tpm2-device=auto"];

  # Fresh server generation on this machine.
  system.stateVersion = "25.11";
}
