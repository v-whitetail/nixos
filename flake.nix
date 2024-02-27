{
  description = "flake for v-whitetail";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = { follows = "nixpkgs"; };
      };
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      v-whitetail = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
	  {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.v = { pkgs, ... }: {
                programs = {
                  home-manager = { enable = true; };
                };
                home = {
                  username = "v";
                  homeDirectory = "/home/v";
                  packages = with pkgs; [
                    neovim
                    rustup
                    alacritty
                    git
                    sway
                    mako
                    gitui
                    bemenu
                    zellij
                    nushell
                    variety
                    wayland
                    swaylock
                    swayidle
                    wdisplays
                    xdg-utils
                    wl-clipboard
		  ];
                  stateVersion = "23.11";
		};
	      };
	    };
	  }
        ];
      };
    };
  };
}

