{
  pkgs,
  config,
  inputs,
  home-manager,
  ...
}:

let
  u_key = "k";
  d_key = "j";
  l_key = "h";
  r_key = "l";
  m_key = "Mod4";
  d_man = "yazi";
  d_task = "btm";
  d_term = "foot";
  d_menu = "fuzzel";
  d_brow = "firefox";
  d_font = "Maple Mono NF";
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    ./swaylock.nix
    ./nixvim.nix
    ./fuzzel.nix
    ./zellij.nix
  ];
  # colorScheme = inputs.nix-colors.colorSchemes.vice;
  colorScheme = {
    slug = "citruszest";
    name = "CitrusZest";
    author = "https://github.com/zootedb0t";
    palette = {
      base00 = "#121212";
      base01 = "#232323";
      base02 = "#232323";
      base03 = "#383838";
      base04 = "#404040";
      base05 = "#767C77";
      base06 = "#BFBFBF";
      base07 = "#F9F9F9";
      base08 = "#FF5454";
      base09 = "#FF7431";
      base0A = "#FFD700";
      base0B = "#00CC7A";
      base0C = "#00FFFF";
      base0D = "#00BFFF";
      base0E = "#FF1A75";
      base0F = "#1AFFA3";
    };
  };
  fonts.fontconfig.enable = true;
  services = {
    mako = {
      enable = true;
      defaultTimeout = 8000;
    };
    swayidle = {
      enable = true;
      events = [
        { event = "lock"; command = "lock"; }
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      ];
    };
  };
  home = {
    username = "v";
    homeDirectory = "/home/v";
    file = { };
    packages = with pkgs; [
      nodejs_21
      rustup
      discord
      dotacat
      neofetch
      grimblast
      libnotify
      wdisplays
      xdg-utils
      pavucontrol
      brightnessctl
      wl-clipboard
      autotiling-rs
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    stateVersion = "23.11";
  };
  programs = let palette = config.colorScheme.palette; in {
    gh.enable = true;
    bat.enable = true;
    lsd.enable = true;
    imv.enable = true;
    fzf.enable = true;
    rio.enable = true;
    gitui.enable = true;
    swayr.enable = true;
    bottom.enable = true;
    firefox.enable = true;
    ripgrep.enable = true;
    thefuck.enable = true;
    swaylock.enable = true;
    home-manager.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    wpaperd = {
      enable = true;
      settings.default.path = "/home/v/Pictures/Wallpapers";
      settings.default.sorting = "random";
      settings.default.duration = "30m";
    };
    nushell = { 
      enable = true;
      envFile.source    = ./DotFiles/env.nu;
      configFile.source = ./DotFiles/config.nu;
    };
    git = {
      enable = true;
      userName  = "v-whitetail";
      userEmail = "white.tail.millwork@gmail.com";
      ignores   = [ "*.swp" "*.swo" ];
    };
  };
  wayland = let palette = config.colorScheme.palette; in {
    windowManager.sway = {
      enable = true;
      config = rec {
        bars = [{
          id = "default_waybar";
          command = "waybar";
        }];
        startup = [
          { command = "wpaperd"; always = true; }
          { command = "autotiling-rs"; always = true; }
        ];
        modifier = m_key;
        left     = l_key;
        right    = r_key;
        up       = u_key;
        down     = d_key;
        terminal = d_term;
        menu     = d_menu;
        window.titlebar = false;
        defaultWorkspace = "workspace number 1";
        gaps = {
            left       = 8;
            right      = 8;
            top        = 8;
            bottom     = 8;
            inner      = 8;
            outer      = 8;
            vertical   = 8;
            horizontal = 8;
        };
    	colors = {
    	  background    = "#${palette.base00}";
    	  focused = {
            background  = "#${palette.base01}";
    	    text        = "#${palette.base07}";
    	    border      = "#${palette.base0F}";
    	    indicator   = "#${palette.base0F}";
    	    childBorder = "#${palette.base0F}";
    	  };
    	  focusedInactive = {
            background  = "#${palette.base01}";
    	    text        = "#${palette.base07}";
    	    border      = "#${palette.base0D}";
    	    indicator   = "#${palette.base0D}";
    	    childBorder = "#${palette.base0D}";
    	  };
    	  unfocused = {
            background  = "#${palette.base01}";
    	    text        = "#${palette.base07}";
    	    border      = "#${palette.base0C}";
    	    indicator   = "#${palette.base0C}";
    	    childBorder = "#${palette.base0C}";
    	  };
    	  placeholder = {
            background  = "#${palette.base01}";
    	    text        = "#${palette.base07}";
    	    border      = "#${palette.base0B}";
    	    indicator   = "#${palette.base0B}";
    	    childBorder = "#${palette.base0B}";
    	  };
    	  urgent = {
    	    text        = "#${palette.base08}";
    	    border      = "#${palette.base08}";
    	    indicator   = "#${palette.base08}";
    	    background  = "#${palette.base08}";
    	    childBorder = "#${palette.base08}";
    	  };
    	};
    	keybindings = with pkgs; {
    	  "${m_key}+Return" = "exec ${d_term}";
    	  "${m_key}+d" = "exec ${d_menu}";
    	  "${m_key}+i" = "exec ${d_brow}";
    	  "${m_key}+e" = "exec ${d_man}";
    	  "${m_key}+q" = "kill";
    	  "${m_key}+b" = "splith";
    	  "${m_key}+v" = "splitv";
    	  "${m_key}+f" = "fullscreen";
    	  "${m_key}+s" = "layout toggle split";
    	  "${m_key}+Shift+space" = "floating toggle";
    	  "${m_key}+${u_key}" = "focus up";
    	  "${m_key}+${d_key}" = "focus down";
    	  "${m_key}+${l_key}" = "focus left";
    	  "${m_key}+${r_key}" = "focus right";
    	  "${m_key}+Shift+${u_key}" = "move up";
    	  "${m_key}+Shift+${d_key}" = "move down";
    	  "${m_key}+Shift+${l_key}" = "move left";
    	  "${m_key}+Shift+${r_key}" = "move right";
    	  "${m_key}+1" = "workspace number 1";
    	  "${m_key}+2" = "workspace number 2";
    	  "${m_key}+3" = "workspace number 3";
    	  "${m_key}+4" = "workspace number 4";
    	  "${m_key}+5" = "workspace number 5";
    	  "${m_key}+6" = "workspace number 6";
    	  "${m_key}+7" = "workspace number 7";
    	  "${m_key}+8" = "workspace number 8";
    	  "${m_key}+9" = "workspace number 9";
    	  "${m_key}+0" = "workspace number 10";
    	  "${m_key}+Shift+1" = "move container to workspace number 1";
    	  "${m_key}+Shift+2" = "move container to workspace number 2";
    	  "${m_key}+Shift+3" = "move container to workspace number 3";
    	  "${m_key}+Shift+4" = "move container to workspace number 4";
    	  "${m_key}+Shift+5" = "move container to workspace number 5";
    	  "${m_key}+Shift+6" = "move container to workspace number 6";
    	  "${m_key}+Shift+7" = "move container to workspace number 7";
    	  "${m_key}+Shift+8" = "move container to workspace number 8";
    	  "${m_key}+Shift+9" = "move container to workspace number 9";
    	  "${m_key}+Shift+0" = "move container to workspace number 10";
    	};
      };
    };
  };
}
