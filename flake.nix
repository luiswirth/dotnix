{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      user = "luis";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      devShell.${system} = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          rnix-lsp
        ];
        buildInputs = [ ];
      };

      nixosConfigurations = {
        lwirth-compute = lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-lwirth-compute.nix
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./home.nix;
            }
          ];
        };
      };
    };
}
