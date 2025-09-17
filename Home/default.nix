{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./foot.nix
    ./fuzzel.nix
    # ./kanshi.nix
    ./nixvim.nix
    ./zellij.nix
    ./shikane.nix
    ./programs.nix
    ./swaylock.nix
    ./hyprland.nix
    ./hyprland.waybar.nix
    # ./niri.nix
    # ./sway.nix
    # ./sway.waybar.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.atelier-seaside;

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      configPackages = with pkgs; [
        hyprland
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "Dracula";
      package = pkgs.dracula-theme;
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
      devenv
      wl-clipboard
      xdg-utils
      cargo-watch
      # rustup
      discord
      dotacat
      grimblast
      libnotify
      pavucontrol
      tailwindcss
      brightnessctl
      via
      protonup
      rofimoji
      brave
      proton-pass
      protonvpn-gui
      protonmail-desktop #requires desktop session to be x11
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    stateVersion = "23.11";
  };
}
