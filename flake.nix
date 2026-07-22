{
  description = "Personal Nix configuration (NixOS + nix-darwin)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Only used by the frozen laptop host.
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nixos-hardware,
    stylix,
  }: let
    user = "luis";

    # Home-manager wired as a system module, shared by both builders.
    hmModule = hmModules: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {inherit inputs user;};
        users.${user}.imports = hmModules;
      };
    };

    mkNixos = {
      system,
      modules,
      home ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules =
          modules
          ++ [home-manager.nixosModules.home-manager (hmModule home)];
      };

    mkDarwin = {
      system ? "aarch64-darwin",
      modules,
      home ? [],
    }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules =
          modules
          ++ [home-manager.darwinModules.home-manager (hmModule home)];
      };
    forEachSystem = f:
      nixpkgs.lib.genAttrs ["aarch64-darwin" "x86_64-linux"]
      (system: f nixpkgs.legacyPackages.${system});
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # Tooling for working on this repo; .envrc loads it through direnv.
    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        packages = [pkgs.alejandra pkgs.nil pkgs.nix-output-monitor];
      };
    });

    nixosConfigurations = {
      # Frozen: old ThinkPad daily driver. Kept for evaluation, not developed.
      lwirth-tp = mkNixos {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z
          stylix.nixosModules.stylix
        ];
        home = [./hosts/laptop/home.nix];
      };

      # Dev server: the repurposed ThinkPad, headless, reached over Tailscale.
      lwirth-server = mkNixos {
        system = "x86_64-linux";
        modules = [
          ./hosts/server.nix
          ./nixos/common.nix
          ./nixos/server.nix
        ];
        home = [./home/core.nix];
      };
    };

    darwinConfigurations = {
      lwirth-macbook = mkDarwin {
        modules = [./darwin/common.nix];
        home = [./home/core.nix ./home/darwin.nix];
      };
    };
  };
}
