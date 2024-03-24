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
    ./foot.nix
    ./sway.nix
    ./fuzzel.nix
    ./nixvim.nix
    ./waybar.nix
    ./zellij.nix
    ./programs.nix
    ./swaylock.nix
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
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
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
    file = {
      ".config/memeshell".source = ./DotFiles/memeshell;
      ".config/zellij/layouts".source = ./DotFiles/zellij/layouts;
    };
    packages = with pkgs; [
      fd
      rustup
      discord
      dotacat
      neofetch
      grimblast
      libnotify
      nodejs_21
      wdisplays
      xdg-utils
      cargo-watch
      pavucontrol
      wl-clipboard
      brightnessctl
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
}
