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
		imports = [ ./import-test.nix ];
                wayland = {
                  windowManager.sway = {
                    enable = true;
                    config = rec {
                      modifier = "Mod4";
                    };
                  };
                };
                programs = {
                  fzf.enable= true;
                  waybar.enable= true;
                  thefuck.enable= true;
                  home-manager.enable= true;
                  nushell = { 
                    enable = true;
                    shellAliases = {
                      vim = "nvim ./";
                      nixrc = "sudo nvim/etc/nixos";
                    };
                  };
                };
                home = {
                  username = "v";
                  homeDirectory = "/home/v";
                  packages = with pkgs; [
                    # terminal & tools
                    gh
                    git
                    gitui
                    neovim
                    rustup
                    zellij
                    nushell
                    alacritty
                    # wayland & sway
                    sway
                    mako
                    swayr
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
                    # flavor
                    swaybg
                    discord
                    dolphin
                    firefox
                    shotman
                    discordo
                    sunpaper
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

