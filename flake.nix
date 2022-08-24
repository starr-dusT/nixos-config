{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
  config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "tstarr";
    in {
      nixosConfigurations = {
        kestrel = lib.nixosSystem {
          inherit system;
    specialArgs = { inherit user; };
    modules = [
            ./configuration.nix
            ./hardware/kestrel.nix
            ./modules/vfio.nix
            ./modules/samba.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
              home-manager.users.${user} = {
                imports = [ ./home-configuration.nix ];
              };
            }
          ];
  };
      };
    };
}
