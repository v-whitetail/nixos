{ config, pkgs, home-manager, ... }:

{
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
}
