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
    ./DotFiles/swaylock.nix
  ];
  colorScheme = inputs.nix-colors.colorSchemes.vice;
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
      nwg-launchers
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
    yazi.enable = true;
    gitui.enable = true;
    swayr.enable = true;
    firefox.enable = true;
    ripgrep.enable = true;
    thefuck.enable = true;
    swaylock.enable = true;
    home-manager.enable = true;
    bottom. enable = true;
    wpaperd = {
      enable = true;
      settings.default.path = "/home/v/Pictures/Wallpapers";
      settings.default.sorting = "random";
      settings.default.duration = "30m";
    };
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
        fidget.enable = true;
        luasnip.enable = true;
        telescope.enable = true;
        which-key.enable = true;
        bufferline.enable = true;
        treesitter.enable = true;
        crates-nvim.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lua.enable = true;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings.sources = [
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
          ];
        };
        lsp = {
          enable = true;
          servers = {
            html.enable = true;
            bashls.enable = true;
            lua-ls.enable = true;
            pyright.enable = true;
            nushell.enable = true;
            nushell.filetypes = [ "nu" ];
            rust-analyzer.enable = true;
            rust-analyzer.installCargo = false;
            rust-analyzer.installRustc = false;
          };
        };
        harpoon = {
          enable = true;
          keymaps.addFile = "<leader>had";
          keymaps.toggleQuickMenu = "<leader>har";
          keymaps.navFile = {
            "1" = "<leader>1";
            "2" = "<leader>2";
            "3" = "<leader>3";
            "4" = "<leader>4";
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [ ];
      colorschemes.base16.enable = true;
      colorschemes.base16.colorscheme = {
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
    	  border          = "${palette.base07}FF";
    	  text            = "${palette.base07}AA";
    	  match           = "${palette.base0B}FF";
    	  selection       = "${palette.base0A}44";
    	  selection-text  = "${palette.base0C}FF";
    	  selection-match = "${palette.base0D}FF";
    	};
      };
    };
    zellij = {
      enable = true;
      settings = {
	    copy_command  = "wl-copy";
	    default_shell = "nu";
	    theme = "nix-colors";
        themes.nix-colors.black   = "#${palette.base00}";
	    themes.nix-colors.bg      = "#${palette.base01}";
        themes.nix-colors.fg      = "#${palette.base05}";
        themes.nix-colors.white   = "#${palette.base07}";
	    themes.nix-colors.red     = "#${palette.base08}";
        themes.nix-colors.orange  = "#${palette.base09}";
        themes.nix-colors.yellow  = "#${palette.base0A}";
        themes.nix-colors.green   = "#${palette.base0B}";
        themes.nix-colors.cyan    = "#${palette.base0C}";
	    themes.nix-colors.blue    = "#${palette.base0D}";
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
            black      = "#${palette.base00}";
            white      = "#${palette.base07}";
	        red        = "#${palette.base08}";
            yellow     = "#${palette.base0A}";
            green      = "#${palette.base0B}";
            cyan       = "#${palette.base0C}";
	        blue       = "#${palette.base0D}";
            magenta    = "#${palette.base0E}";
	      };
	      cursor = {
	        text       = "#${palette.base05}";
	        cursor     = "#${palette.base0F}";
	      };
	      normal = {
            black      = "#${palette.base00}";
            white      = "#${palette.base07}";
	        red        = "#${palette.base08}";
            yellow     = "#${palette.base0A}";
            green      = "#${palette.base0B}";
            cyan       = "#${palette.base0C}";
	        blue       = "#${palette.base0D}";
            magenta    = "#${palette.base0E}";
	      };
	      primary = {
	        background = "#${palette.base01}";
	        foreground = "#${palette.base05}";
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
    waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "bottom";
        height = 24;
        modules-left = [
          "sway/workspaces" "sway/mode" "sway/window"
        ];
        modules-right = [
          "tray" "cpu" "memory" "backlight" "pulseaudio"
          "network" "clock" "battery" "custom/screenshot" "custom/power"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "sway/window" = {
          format = "{}";
        };
        "tray" = {
          icon-size = 14;
          spacing = 5;
        };
        "clock" = {
          tooltip-format = "{:%A %B %d %Y | %H:%M}";
          format = "  {:%a %d %b  %I:%M %p}";
          format-alt = "  {:%d/%m/%Y  %H:%M:%S}";
          interval = 1;
        };
        "cpu" = {
          format = "  {usage: >3}%";
          on-click = "alacritty -e htop";
        };
        "memory" = {
          format = "  {: >3}%";
          on-click = "alacritty -e btm";
        };
        "backlight" = {
          format = "{icon} {percent: >3}%";
          format-icons = ["" ""];
          on-scroll-down = "brightnessctl -c backlight set 1%-";
          on-scroll-up = "brightnessctl -c backlight set +1%";
        };
        "battery" = {
          states = {
            warning = 25;
            critical = 15;
          };
          format = "{icon} {capacity: >3}%";
          format-icons = [" " " " " " " " " "];
        };
        "network" = {
          format = "⚠ Disabled";
          format-wifi = "  {essid}";
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}";
          format-disconnected = "⚠ Disconnected";
          on-click = "alacritty -e nmtui";
        };
        "pulseaudio" = {
          scroll-step = 1;
          format = "{icon} {volume: >3}%";
          format-bluetooth = "{icon} {volume: >3}%";
          format-muted =" muted";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          format ="⏻";
          on-click = "nwgbar";
          tooltip = false;
        };
        "custom/screenshot" = {
          format = "";
          on-click = "grimblast copy area";
        };
      }];
      style = 
      ''
        * {
            color: #${palette.base05};
            border: 0px;
            border-radius: 0px;
            padding: 0px 0px;
            font-family:Maple-Mono-NF;
            font-size: 14px;
            margin-right: 4px;
            margin-left: 4px;
            padding-bottom:2px;
           }
        window#waybar {
            background: #${palette.base01};
            opacity: 0.80;
        }
        #workspaces button {
            padding: 4px 0px 2px 0px;
            border-bottom: 2px;
            color: #${palette.base05};
            border-color: #${palette.base05};
            border-style: solid;
            margin-top:2px;
        }
        #workspaces button.focused {
            border-color: #${palette.base08};
        }
        #mode {
            color: #${palette.base05};
            margin-bottom: 3px;
        }
        #clock, #battery, #cpu, #memory, #temperature, #backlight, #network,
        #pulseaudio, #mode, #tray, #window, #custom-power, #custom-screenshot
        {
            padding: 2px 2px;
            border-bottom: 2px;
            border-style: solid;
        }
        #custom-power,
        #custom-screenshot {
            border-style: hidden;
            padding: 2px 4px;
        }
        #clock { color:#${palette.base0D}; }
        #backlight { color: #${palette.base0A}; }
        #battery { color: #${palette.base0E}; }
        #battery.charging { color: #${palette.base0B}; }
        @keyframes blink {
            to {
                color: #${palette.base07};
                background-color: #${palette.base03};
            }
        }
        #battery.critical:not(.charging) {
            background: #${palette.base0E};
            color: #${palette.base08};
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }
        #cpu { color:#${palette.base08}; }
        #memory { color: #${palette.base09}; }
        #network{ color:#${palette.base0C}; }
        #network.disabled { color:#${palette.base03}; }
        #network.disconnected { color: #${palette.base05}; }
        #pulseaudio { color: #${palette.base0B}; }
        #pulseaudio.muted { color: #${palette.base03}; }
        #window{
            border-style: hidden;
            margin-top:1px;  
        }    
      '';
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
