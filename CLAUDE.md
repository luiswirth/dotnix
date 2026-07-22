# dotnix

Personal Nix configuration for a macOS daily driver and a headless NixOS dev
server, from one flake. Home Manager carries the portable shell/editor/CLI world
shared by both.

## Hosts

- `darwinConfigurations.lwirth-macbook` — Apple Silicon daily driver (nix-darwin).
- `nixosConfigurations.lwirth-server` — headless dev server, the repurposed
  ThinkPad, reached over Tailscale.
- `nixosConfigurations.lwirth-tp` — the old ThinkPad desktop. Frozen: kept so it
  still evaluates, not developed. Its Wayland/desktop config never moves out of
  `hosts/laptop`.

## Layout

One concern is one file until it outgrows the head; folders only then.

- `flake.nix` — inputs (every one `follows` nixpkgs) and the `mkNixos`/`mkDarwin`
  host builders. `formatter` is alejandra (`nix fmt .`).
- `home/core.nix` — cross-platform Home Manager: zsh, helix, git, ssh, jujutsu,
  CLI/dev tools. Imported by every host. Nothing GUI, nothing platform-specific.
  Linux-only systemd services are guarded with `lib.mkIf pkgs.stdenv.isLinux`.
- `home/darwin.nix` — mac-only Home Manager (Ghostty config, brew shellenv on
  PATH, nh, `UseKeychain`, ETH VLSI ssh hosts).
- `darwin/` — nix-darwin system config plus `nix.custom.conf`.
- `nixos/` — `common.nix` (shared baseline) and `server.nix` (dev-server role).
- `hosts/` — per-host wiring; `hosts/laptop/` holds the frozen desktop.

## Invariants

- **Determinate Nix owns the daemon on macOS.** `nix.enable = false` in
  nix-darwin, or the two fight over `/etc/nix/nix.conf` on every switch. Daemon
  settings therefore live in `darwin/nix.custom.conf` (tracked, symlinked via
  `environment.etc`), not `nix.settings`.
- **GUI apps are Homebrew casks, CLI is nix.** nixpkgs' darwin GUI builds are
  second-class; casks are declared in the nix-darwin `homebrew` module so they
  stay version-controlled. `onActivation.cleanup = "none"` until the Brewfile is
  authoritative.
- **Toolchains are per-project, not global.** cmake/llvm/rust/etc. belong in each
  project's own `flake.nix` devShell, loaded by direnv (`.envrc` → `use flake`).
  Keep the global set lean.
- **nh differs by platform.** NixOS uses the `programs.nh` module (can GC the
  system profile); darwin drives nh from Home Manager (nix-darwin has no module).
- **AeroSpace runs via nixpkgs + launchd**, not a cask and not yabai: no SIP
  disable. `start-at-login = false` (the module's launchd agent handles autostart).

## Verifying

The Mac cannot build Linux derivations, so verify with evaluation, not build:

    nix eval --raw .#nixosConfigurations.lwirth-server.config.system.build.toplevel.drvPath
    nix eval --raw .#darwinConfigurations.lwirth-macbook.system.drvPath

`nixos-rebuild --flake github:...` caches the flake for ~1h; pass `--refresh` (or
pin the commit rev) to pick up a just-pushed change.

## Known gaps

- Server root is LUKS1; TPM auto-unlock needs LUKS2. Until converted, a cold boot
  waits for the passphrase at the console. See issue #1.
