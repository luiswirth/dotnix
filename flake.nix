{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.40.0";
    hy3 = {
      url = "github:outfoxxed/hy3/hl0.40.0";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    hyprland,
    hy3,
  } @ inputs: let
    system = "x86_64-linux";
    user = "luis";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    formatter.${system} = pkgs.nixpkgs-fmt;

    devShell.${system} = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nil
      ];
      buildInputs = [];
    };

    nixosConfigurations = {
      lwirth-tp = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          ./hardware-lwirth-tp.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z

          hyprland.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.${user}.imports = [
              ./home.nix

              hyprland.homeManagerModules.default
            ];
          }
        ];
      };
    };
  };
}
