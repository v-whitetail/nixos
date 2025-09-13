{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
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
      settings.default-timeout = 8000;
    };
    swayidle = {
      enable = true;
      events = [
        { event = "lock"; command = "lock"; }
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      ];
    };
    wpaperd = {
      enable = true;
      settings.default.path = "/home/v/Pictures/Wallpapers";
      settings.default.sorting = "random";
      settings.default.duration = "30m";
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
      nodejs
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
      rustup
      openssl_3
      pkg-config
      cargo-watch
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
