{ config, pkgs, home-manager, ... }:

let
  mod = "Mod4";
  term = "alacritty";
in
{
  wayland = {
    windowManager.sway = {
      enable = true;
      config = rec {
        modifier = mod;
        terminal = term;
        defaultWorkspace = "workspace number 1";
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
	keybindings = with pkgs; {
	  "${mod}+Return" = "exec ${term}";
	  "${mod}+q" = "kill";
	  "${mod}+1" = "workspace number 1";
	  "${mod}+2" = "workspace number 2";
	  "${mod}+3" = "workspace number 3";
	  "${mod}+4" = "workspace number 4";
	  "${mod}+5" = "workspace number 5";
	  "${mod}+6" = "workspace number 6";
	  "${mod}+7" = "workspace number 7";
	  "${mod}+8" = "workspace number 8";
	  "${mod}+9" = "workspace number 9";
	  "${mod}+10" = "workspace number 10";
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
