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
  d_menu = "fuzzel";
  d_term = "alacritty";
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
  ];
  colorScheme = inputs.nix-colors.colorSchemes.icy;
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
      variety
      flameshot
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
    waybar.enable = true;
    firefox.enable = true;
    ripgrep.enable = true;
    thefuck.enable = true;
    i3status.enable = true;
    swaylock.enable = true;
    home-manager.enable = true;
    nixvim = {
      enable = true;
      options = {
        wrap = true;
        backup = false;
        number = true;
        undofile = true;
        swapfile = false;
        hlsearch = false;
        expandtab = true;
        incsearch = true;
        smartindent = true;
        termguicolors = true;
        relativenumber = true;
        tabstop = 4;
        scrolloff = 8;
        shiftwidth = 4;
        updatetime = 50;
        softtabstop = 4;
        colorcolumn = "80";
      };
      plugins = {
        harpoon.enable = true;
      };
      colorschemes.base16.enable = true;
      colorschemes.base16.customColorScheme = {
        base00 = "#${palette.base00}";
        base01 = "#${palette.base01}";
        base02 = "#${palette.base02}";
        base03 = "#${palette.base03}";
        base04 = "#${palette.base04}";
        base05 = "#${palette.base05}";
        base06 = "#${palette.base06}";
        base07 = "#${palette.base07}";
        base08 = "#${palette.base08}";
        base09 = "#${palette.base09}";
        base0A = "#${palette.base0A}";
        base0B = "#${palette.base0B}";
        base0C = "#${palette.base0C}";
        base0D = "#${palette.base0D}";
        base0E = "#${palette.base0E}";
        base0F = "#${palette.base0F}";
      };
      extraConfigLua = ''
      	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      '';
      globals.mapleader = " ";
      keymaps = [
        { mode = "i"; key = "jf"; action = "<Esc>"; }
        { mode = "n"; key = "fu"; action = "<C-R>"; }
        { mode = "n"; key = "<leader>fl"; action = "<C-w>l"; }
        { mode = "n"; key = "<leader>fh"; action = "<C-w>h"; }
        { mode = "n"; key = "<leader>fk"; action = "<C-w>k"; }
        { mode = "n"; key = "<leader>fj"; action = "<C-w>j"; }
        { mode = "n"; key = "<leader>fe"; action = ":Explore<CR>"; }
        { mode = "n"; key = "<leader>term"; action = ":terminal<CR>"; }
        { mode = "n"; key = "<leader>split"; action = ":split<CR>"; }
        { mode = "n"; key = "<leader>vsplit"; action = ":vsplit<CR>"; }
        { mode = "n"; key = "J"; action = "mzJ`z"; }
        { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
        { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }
        { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
        { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
        {
          mode = "n";
          key = "<leader>com";
          action = "0t,2li<Enter><Esc>V=<Esc>";
        }
        {
          mode = "n";
          key = "<leader>per";
          action = "0t.a<Enter><Esc>V=q002t.a<Enter><Esc>V=q8@0";
        }
        {
          mode = "t";
          key = "jf";
          action = "<C-\\><C-n>";
          options.noremap = true;
        }
      ];
    };
    fuzzel = {
      enable = true;
      settings = {
    	main.prompt = "<&'i str>" ;
    	border.radius = 2;
    	colors = {
    	  background      = "${palette.base00}AA";
    	  border          = "${palette.base0F}FF";
    	  text            = "${palette.base06}AA";
    	  match           = "${palette.base0D}FF";
    	  selection       = "${palette.base06}44";
    	  selection-text  = "${palette.base0D}FF";
    	  selection-match = "${palette.base0A}FF";
    	};
      };
    };
    zellij = {
      enable = true;
      settings = {
	    copy_command  = "wl-copy";
	    default_shell = "nu";
	    theme = "nix-colors";
	    themes.nix-colors.fg      = "#${palette.base06}";
	    themes.nix-colors.bg      = "#${palette.base00}";
	    themes.nix-colors.red     = "#${palette.base08}";
	    themes.nix-colors.blue    = "#${palette.base0D}";
	    themes.nix-colors.cyan    = "#${palette.base0C}";
	    themes.nix-colors.black   = "#${palette.base00}";
	    themes.nix-colors.green   = "#${palette.base0B}";
	    themes.nix-colors.white   = "#${palette.base06}";
	    themes.nix-colors.orange  = "#${palette.base09}";
	    themes.nix-colors.yellow  = "#${palette.base09}";
	    themes.nix-colors.magenta = "#${palette.base0E}";
	    ui.pane_frames.rounded_corners = true;
	    keybinds = {
	      shared = {
	        "unbind \"Ctrl g\"" = [];
	        "unbind \"Ctrl p\"" = [];
	        "unbind \"Ctrl t\"" = [];
	        "unbind \"Ctrl n\"" = [];
	        "unbind \"Ctrl h\"" = [];
	        "unbind \"Ctrl s\"" = [];
	        "unbind \"Ctrl o\"" = [];
	        "unbind \"Ctrl q\"" = [];
	      };
	      normal = {
	        "bind \"Alt t\"" = { SwitchToMode =     "tab"; };
	        "bind \"Alt p\"" = { SwitchToMode =    "pane"; };
	        "bind \"Alt h\"" = { SwitchToMode =    "move"; };
	        "bind \"Alt g\"" = { SwitchToMode =  "locked"; };
	        "bind \"Alt n\"" = { SwitchToMode =  "resize"; };
	        "bind \"Alt s\"" = { SwitchToMode =  "search"; };
	        "bind \"Alt o\"" = { SwitchToMode = "session"; };
	        "bind \"Alt q\"" = {         Quit =        []; };
	      };
	      tab     = { "bind \"Alt t\"" = { SwitchToMode = "normal"; }; };
	      move    = { "bind \"Alt h\"" = { SwitchToMode = "normal"; }; };
	      pane    = { "bind \"Alt p\"" = { SwitchToMode = "normal"; }; };
	      locked  = { "bind \"Alt g\"" = { SwitchToMode = "normal"; }; };
	      resize  = { "bind \"Alt n\"" = { SwitchToMode = "normal"; }; };
	      search  = { "bind \"Alt s\"" = { SwitchToMode = "normal"; }; };
	      session = { "bind \"Alt o\"" = { SwitchToMode = "normal"; }; };
	    };
      };
    };
    alacritty = {
      enable = true;
      settings = {
	    font.size = 10;
	    window.opacity = 0.85;
	    live_config_reload = true;
	    colors = {
	      bright = {
	        red        = "#${palette.base08}";
	        blue       = "#${palette.base0D}";
	        cyan       = "#${palette.base0C}";
	        black      = "#${palette.base00}";
	        green      = "#${palette.base0B}";
	        white      = "#${palette.base07}";
	        yellow     = "#${palette.base0A}";
	        magenta    = "#${palette.base0F}";
	      };
	      cursor = {
	        text       = "#${palette.base06}";
	        cursor     = "#${palette.base04}";
	      };
	      normal = {
	        red        = "#${palette.base08}";
	        blue       = "#${palette.base0D}";
	        cyan       = "#${palette.base0C}";
	        black      = "#${palette.base00}";
	        green      = "#${palette.base0B}";
	        white      = "#${palette.base07}";
	        yellow     = "#${palette.base0A}";
	        magenta    = "#${palette.base0F}";
	      };
	      primary = {
	        background = "#${palette.base02}";
	        foreground = "#${palette.base07}";
	      };
	      draw_bold_text_with_bright_colors = true;
	    };
      };
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
        defaultWorkspace = "workspace number 1";
        modifier = m_key;
        left     = l_key;
        right    = r_key;
        up       = u_key;
        down     = d_key;
        terminal = d_term;
        menu     = d_menu;
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
    	window.titlebar = false;
    	colors = {
    	  background    = "#${palette.base00}";
    	  focused = {
    	    text        = "#${palette.base06}";
    	    border      = "#${palette.base0D}";
    	    indicator   = "#${palette.base0B}";
    	    background  = "#${palette.base00}";
    	    childBorder = "#${palette.base08}";
    	  };
    	  focusedInactive = {
    	    text        = "#${palette.base03}";
    	    border      = "#${palette.base00}";
    	    indicator   = "#${palette.base00}";
    	    background  = "#${palette.base00}";
    	    childBorder = "#${palette.base00}";
    	  };
    	  placeholder = {
    	    text        = "#${palette.base03}";
    	    border      = "#${palette.base00}";
    	    indicator   = "#${palette.base00}";
    	    background  = "#${palette.base00}";
    	    childBorder = "#${palette.base00}";
    	  };
    	  unfocused = {
    	    text        = "#${palette.base03}";
    	    border      = "#${palette.base00}";
    	    indicator   = "#${palette.base00}";
    	    background  = "#${palette.base00}";
    	    childBorder = "#${palette.base00}";
    	  };
    	  urgent = {
    	    text        = "#${palette.base09}";
    	    border      = "#${palette.base0E}";
    	    indicator   = "#${palette.base0E}";
    	    background  = "#${palette.base0E}";
    	    childBorder = "#${palette.base0E}";
    	  };
    	};
    	keybindings = with pkgs; {
    	  "${m_key}+Return" = "exec ${d_term}";
    	  "${m_key}+d" = "exec ${d_menu}";
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
