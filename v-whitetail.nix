{ config, pkgs, home-manager, ... }:

let
  mod = "Mod4";
  term = "rio";
  u_key = "k";
  d_key = "j";
  l_key = "h";
  r_key = "l";
  d_menu = "fuzzel";
in
{
  wayland = {
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
  services = {
    mako = {
      enable = true;
      defaultTimeout = 8000;
    };
    swayidle.enable = true;
  };
  programs = {
    gh.enable = true;
    bat.enable = true;
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
    alacritty.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      ignores = [ "*.swp" "*.swo" ];
      userName = "v-whitetail";
      userEmail = "white.tail.millwork@gmail.com";
    };
    nushell = { 
      enable = true;
      shellAliases = {
	":q" = "exit";
	"cat" = "bat";
	"vim" = "nvim ./";
	"cdnix" = "cd /home/v/crystalPeak/nixos";
	"manix" = "man configuration.nix";
	"honix" = "man home-configuration.nix";
	"nixrc" = "nvim /home/v/crystalPeak/nixos";
	"ftest" = "sudo nixos-rebuild --flake .#v-whitetail test";
	"fbuild" = "sudo nixos-rebuild --flake .#v-whitetail switch";
      };
      extraConfig = ''
        $env.EDITOR = nvim
        $env.PROMPT_INDICATOR_VI_INSERT = " 'i> "
        $env.PROMPT_INDICATOR_VI_NORMAL = " 'n> "
        $env.config = { show_banner: false, edit_mode: vi }
	def "nu-wifi" [] {
	  let wifi_scan = nmcli d wifi list
	  let header_end = $wifi_scan | str index-of "\n"
	  let header_row = $wifi_scan | str substring 0..$header_end
	  let ssid_head = $header_row | str index-of " SSID"
	  let ssid_tail = $header_row | str index-of " MODE"
	  let scan_data = $wifi_scan  | str substring $header_end..
	  let input_row = $scan_data  | fzf
	  let wifi_name = $input_row  | str substring $ssid_head..$ssid_tail | str trim
	  print "\t Input Password:"
	  let pass_word = input -s
	  nmcli d wifi connect $wifi_name password $pass_word
	}
      '';
    };
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
}
