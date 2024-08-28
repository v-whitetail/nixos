{
  description = "flake for v-whitetail";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

  };

  outputs = inputs@ {
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      v-whitetail = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./server-configuration.nix
        ];
      };
    };
  };
}

