{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    stylix,
  } @ inputs: let
    system = "x86_64-linux";
    user = "luis";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    devShell.${system} = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [nil];
      buildInputs = [];
    };

    nixosConfigurations = {
      lwirth-tp = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          ./hardware-lwirth-tp.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z

          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.${user}.imports = [
              ./home.nix
            ];
          }
        ];
      };
    };
  };
}
