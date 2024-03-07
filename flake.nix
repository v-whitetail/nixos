{
  description = "flake for v-whitetail";

  inputs = {

    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager";

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{
    self,
    nixvim,
    nixpkgs,
    nix-colors,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      v-whitetail = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                inherit nixvim;
                inherit nix-colors;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.v = import ./v-whitetail.nix;
            };
          }
        ];
      };
    };
  };
}

