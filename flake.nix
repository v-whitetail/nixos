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
                wayland = {
                  windowManager.sway = {
                    enable = true;
                    config = rec {
                      modifier = "Mod4";
		    };
		  };
		};
                programs = {
                  fzf = { enable = true; };
                  waybar = { enable = true; };
                  thefuck = { enable = true; };
                  home-manager = { enable = true; };
                };
                home = {
                  username = "v";
                  homeDirectory = "/home/v";
                  packages = with pkgs; [
                    gh		# terminal & tools
                    git
                    gitui
                    neovim
                    rustup
                    zellij
                    nushell
                    alacritty
                    sway	# wayland & sway
                    mako
                    bemenu
                    fuzzel
                    wayland
                    i3status
                    swaylock
                    swayidle
                    libnotify
                    wdisplays
                    xdg-utils
                    wl-clipboard
                    discord	# flavor
                    dolphin
                    firefox
                    shotman
                    variety
                    discordo
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

