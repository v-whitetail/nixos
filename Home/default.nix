{
  pkgs,
  inputs,
  ...
}:

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

  colorScheme = inputs.nix-colors.colorSchemes.vice;

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal = {
      enable = true;
      config.common.default = "wlr";
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-gtk";
      package = pkgs.catppuccin-gtk;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "catppuccin-qt5ct";
      package = pkgs.catppuccin-qt5ct;
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
      ".config/devshells".source = ./DotFiles/devshells;
    };
    packages = with pkgs; [
      wl-clipboard
      xdg-utils
      cargo-watch
      nodejs
      rustup
      discord
      dotacat
      fermyon-spin
      grimblast
      libnotify
      wdisplays
      autotiling-rs
      pavucontrol
      tailwindcss
      brightnessctl
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
