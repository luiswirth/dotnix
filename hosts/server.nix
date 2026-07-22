# Dev server host: the repurposed ThinkPad, headless.
# Reuses the machine's generated hardware config; adds boot + networking.
{lib, ...}: {
  imports = [./laptop/hardware.nix];

  networking.hostName = "lwirth-server";

  # Encrypt swap with a fresh random key each boot (root is LUKS; swap was not).
  # Reformats on activation, so no hibernation/resume, which a server never uses.
  swapDevices = lib.mkForce [
    {
      device = "/dev/disk/by-partuuid/4bc0c4eb-2543-9844-9334-6dd0374be93b";
      randomEncryption.enable = true;
    }
  ];
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
  # Auto-unlock the encrypted root via the TPM so the box boots unattended.
  # PREREQUISITE: the root header is currently LUKS1; TPM enrollment needs
  # LUKS2. Convert first (with a header backup), then enroll. Until then this
  # option is a harmless no-op and boot falls back to the passphrase. See #1.
  #   cryptsetup luksHeaderBackup /dev/nvme0n1p2 --header-backup-file hdr.img
  #   cryptsetup convert /dev/nvme0n1p2 --type luks2
  #   systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2
  boot.initrd.luks.devices."luks-5bed133c-e06f-42ec-aa69-19a763197b8f".crypttabExtraOpts = ["tpm2-device=auto"];

  # Fresh server generation on this machine.
  system.stateVersion = "25.11";
}
