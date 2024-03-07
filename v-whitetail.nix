{ config, pkgs, inputs, nix-colors, home-manager, ... }:

let
  mod = "Mod4";
  term = "alacritty";
  u_key = "k";
  d_key = "j";
  l_key = "h";
  r_key = "l";
  d_menu = "fuzzel";
in
{
  imports = [ nix-colors.homeManagerModules.default ];
  colorScheme = nix-colors.colorSchemes.lime;
  services = {
    mako = {
      enable = true;
      defaultTimeout = 8000;
    };
    swayidle.enable = true;
  };
  home = {
    username = "v";
    homeDirectory = "/home/v";
    packages = with pkgs; [
      rustup
      swaybg
      discord
      dolphin
      shotman
      libnotify
      wdisplays
      xdg-utils
      wl-clipboard
    ];
    stateVersion = "23.11";
  };
  programs = let palette = config.colorScheme.palette; in {
    gh.enable = true;
    bat.enable = true;
    eza.enable = true;
    fzf.enable = true;
    rio.enable = true;
    gitui.enable = true;
    swayr.enable = true;
    fuzzel.enable = true;
    neovim.enable = true;
    waybar.enable = true;
    zellij.enable = true;
    firefox.enable = true;
    ripgrep.enable = true;
    thefuck.enable = true;
    i3status.enable = true;
    swaylock.enable = true;
    home-manager.enable = true;
    alacritty = {
      enable = true;
      settings = {
	font.size = 10;
	window.opacity = 0.6;
	live_config_reload = true;
	colors = {
	  bright = {
	    red = "#${palette.base08}";
	    blue = "#${palette.base0D}";
	    cyan = "#${palette.base0C}";
	    green = "#${palette.base0B}";
	    white = "#${palette.base06}";
	    black = "#${palette.base00}";
	    yellow = "#${palette.base09}";
	    magenta = "#${palette.base0E}";
	  };
	  cursor = {
	    text = "#${palette.base06}";
	    cursor = "#${palette.base06}";
	  };
	  normal = {
	    red = "#${palette.base08}";
	    blue = "#${palette.base0D}";
	    cyan = "#${palette.base0C}";
	    black = "#${palette.base00}";
	    green = "#${palette.base0B}";
	    white = "#${palette.base06}";
	    yellow = "#${palette.base0A}";
	    magenta = "#${palette.base0E}";
	  };
	  primary = {
	    background = "#${palette.base00}";
	    foreground = "#${palette.base06}";
	  };
	  draw_bold_text_with_bright_colors = true;
	};
      };
    };
    nushell = { 
      enable = true;
      envFile.source = ./DotFiles/env.nu;
      configFile.source = ./DotFiles/config.nu;
    };
    git = {
      enable = true;
      ignores = [ "*.swp" "*.swo" ];
      userName = "v-whitetail";
      userEmail = "white.tail.millwork@gmail.com";
    };
  };
  wayland = let palette = config.colorScheme.palette; in {
    windowManager.sway = {
      enable = true;
      config = rec {
        modifier = mod;
        up = u_key;
        down = d_key;
        left = l_key;
        right = r_key;
        menu = d_menu;
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
	};
	window.titlebar = false;
	colors = {
	  background = "#${palette.base00}";
	  focused = {
	    text = "#${palette.base06}";
	    border = "#${palette.base0C}";
	    indicator = "#${palette.base0B}";
	    background = "#${palette.base0D}";
	    childBorder = "#${palette.base0C}";
	  };
	  focusedInactive = {
	    text = "#${palette.base06}";
	    border = "#${palette.base00}";
	    indicator = "#${palette.base00}";
	    background = "#${palette.base00}";
	    childBorder = "#${palette.base00}";
	  };
	  placeholder = {
	    text = "#${palette.base06}";
	    border = "#${palette.base06}";
	    indicator = "#${palette.base06}";
	    background = "#${palette.base06}";
	    childBorder = "#${palette.base06}";
	  };
	  unfocused = {
	    text = "#${palette.base06}";
	    border = "#${palette.base00}";
	    indicator = "#${palette.base00}";
	    background = "#${palette.base00}";
	    childBorder = "#${palette.base00}";
	  };
	  urgent = {
	    text = "#${palette.base08}";
	    border = "#${palette.base08}";
	    indicator = "#${palette.base0E}";
	    background = "#${palette.base0E}";
	    childBorder = "#${palette.base0E}";
	  };
	};
	keybindings = with pkgs; {
	  "${mod}+Return" = "exec ${term}";
	  "${mod}+d" = "exec ${d_menu}";
	  "${mod}+q" = "kill";
	  "${mod}+b" = "splith";
	  "${mod}+v" = "splitv";
	  "${mod}+f" = "fullscreen";
	  "${mod}+s" = "layout toggle split";
	  "${mod}+Shift+space" = "floating toggle";
	  "${mod}+${u_key}" = "focus up";
	  "${mod}+${d_key}" = "focus down";
	  "${mod}+${l_key}" = "focus left";
	  "${mod}+${r_key}" = "focus right";
	  "${mod}+Shift+${u_key}" = "move up";
	  "${mod}+Shift+${d_key}" = "move down";
	  "${mod}+Shift+${l_key}" = "move left";
	  "${mod}+Shift+${r_key}" = "move right";
	  "${mod}+1" = "workspace number 1";
	  "${mod}+2" = "workspace number 2";
	  "${mod}+3" = "workspace number 3";
	  "${mod}+4" = "workspace number 4";
	  "${mod}+5" = "workspace number 5";
	  "${mod}+6" = "workspace number 6";
	  "${mod}+7" = "workspace number 7";
	  "${mod}+8" = "workspace number 8";
	  "${mod}+9" = "workspace number 9";
	  "${mod}+0" = "workspace number 10";
	  "${mod}+Shift+1" = "move container to workspace number 1";
	  "${mod}+Shift+2" = "move container to workspace number 2";
	  "${mod}+Shift+3" = "move container to workspace number 3";
	  "${mod}+Shift+4" = "move container to workspace number 4";
	  "${mod}+Shift+5" = "move container to workspace number 5";
	  "${mod}+Shift+6" = "move container to workspace number 6";
	  "${mod}+Shift+7" = "move container to workspace number 7";
	  "${mod}+Shift+8" = "move container to workspace number 8";
	  "${mod}+Shift+9" = "move container to workspace number 9";
	  "${mod}+Shift+0" = "move container to workspace number 10";
	};
      };
    };
  };
}
