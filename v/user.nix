{ config, pkgs, home-manager, ... }:

let
  mod = "Mod4";
in
{
  wayland = {
    windowManager.sway = {
      enable = true;
      config = rec {
        modifier = mod;
        gaps = {
	  top = 8;
	  left = 8;
	  inner = 8;
	  outer = 8;
	  right = 8;
	  bottom = 8;
	  vertical = 8;
	  horizontal = 8;
	  smartGaps = true;
	};
      };
    };
  };
  programs = {
    fzf.enable = true;
    waybar.enable = true;
    thefuck.enable = true;
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
}
