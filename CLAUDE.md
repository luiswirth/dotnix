# dotnix

Personal Nix configuration for a macOS daily driver and a headless NixOS dev
server, from one flake.
Home Manager carries the portable shell/editor/CLI world shared by both.

## Hosts

- `darwinConfigurations.lwirth-macbook`:
  Apple Silicon daily driver (nix-darwin).
- `nixosConfigurations.lwirth-server`:
  Headless dev server, the repurposed ThinkPad, reached over Tailscale.
- `nixosConfigurations.lwirth-tp`:
  The old ThinkPad desktop.
  Frozen: kept so it still evaluates, not developed.
  Its Wayland/desktop config never moves out of `hosts/laptop`.

## Layout

One concern is one file until it outgrows the head, folders only then.

- `flake.nix`:
  Inputs (every one `follows` nixpkgs) and the `mkNixos`/`mkDarwin` host builders.
  `formatter` is alejandra (`nix fmt .`).
- `home/core.nix`:
  Cross-platform Home Manager: zsh, helix, git, ssh, jujutsu, CLI/dev tools.
  Imported by every host.
  Nothing GUI, nothing platform-specific.
  Linux-only systemd services are guarded with `lib.mkIf pkgs.stdenv.isLinux`.
- `home/darwin.nix`:
  Mac-only Home Manager (Ghostty config, brew shellenv on PATH, nh, `UseKeychain`, ETH VLSI ssh hosts).
- `darwin/`:
  nix-darwin system config plus `nix.custom.conf`.
- `nixos/`:
  `common.nix` (shared baseline) and `server.nix` (dev-server role).
- `hosts/`:
  Per-host wiring. `hosts/laptop/` holds the frozen desktop.

## Guidelines

- **Trust defaults:**
  Declare a default only where it is load-bearing.
  Deviations of course need to be declared.

## Invariants

- **dotnix knows nothing of dotprivate:**
  A public flake must never depend on the private repo.
  Anything that must be version-controlled but not public lives in dotprivate instead.
- **Determinate Nix owns the daemon on macOS:**
  `nix.enable = false` in nix-darwin, or the two fight over `/etc/nix/nix.conf` on every switch.
  Daemon settings therefore live in `darwin/nix.custom.conf`
  (tracked, symlinked via `environment.etc`), not `nix.settings`.
- **GUI apps are Homebrew casks, CLI is nix:**
  nixpkgs' darwin GUI builds are second-class.
  Casks are declared in the nix-darwin `homebrew` module so they stay version-controlled.
  `onActivation.cleanup = "none"` until the Brewfile is authoritative.
- **Toolchains are per-project, not global:**
  cmake/llvm/rust/etc. belong in each project's own `flake.nix` devShell,
  loaded by direnv (`.envrc` with `use flake`).
  Keep the global set lean.
- **nh differs by platform:**
  NixOS uses the `programs.nh` module (can GC the system profile).
  darwin drives nh from Home Manager (nix-darwin has no module).
- **AeroSpace runs via nixpkgs + launchd**, not a cask and not yabai, so no SIP disable.
  `start-at-login = false` (the module's launchd agent handles autostart).
- **The Claude CLI has a second account available:**
  `claude` uses the default profile in `~/.claude`.
  The `claude-alt` alias points `CLAUDE_CONFIG_DIR` at `~/.claude-alt`,
  a separate profile with its own login.
  Which account sits in which profile is not this repo's concern.
- **The checkout path is defined once**, as `flakePath` in `flake.nix`'s `specialArgs`/`extraSpecialArgs`.
  Every `programs.nh.flake` takes it from there.
  Hardcoding the literal per host is how the two platforms drifted apart before.
- **The server builds from two different sources, on purpose:**
  A manual `nh os switch` builds the local checkout, working tree and all,
  so iteration is immediate.
  `system.autoUpgrade` builds `github:luiswirth/dotnix` weekly,
  so unattended rebuilds only ever apply reviewed, pushed commits.
  The consequence: anything applied locally but never pushed is silently reverted within a week.
  Note also that a git flake ignores untracked files,
  so a new `.nix` file that has not been `git add`ed evaluates as absent.

## Verifying

The Mac cannot build Linux derivations, so verify with evaluation, not build:

    nix eval --raw .#nixosConfigurations.lwirth-server.config.system.build.toplevel.drvPath
    nix eval --raw .#darwinConfigurations.lwirth-macbook.system.drvPath

`nixos-rebuild --flake github:...` caches the flake for ~1h.
Pass `--refresh` (or pin the commit rev) to pick up a just-pushed change.
