{
  description = "flake for v-whitetail";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = { follows = "nixpkgs"; };
      };
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-colors, home-manager, ...  }: {
    nixosConfigurations = {
      v-whitetail = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = { inherit nix-colors; };
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      useGlobalPkgs = true;
	      useUserPackages = true;
	      users.v = { pkgs, ... }: {
	        imports = [ ./v-whitetail.nix ];
	      };
	    };
	  }
	];
      };
    };
  };
}

