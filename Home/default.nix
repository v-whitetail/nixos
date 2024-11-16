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
    ./niri.nix
    ./sway.nix
    ./fuzzel.nix
    ./nixvim.nix
    ./waybar.nix
    ./zellij.nix
    ./programs.nix
    ./swaylock.nix
    # ./hyprland.nix
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
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
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
    kanshi = {
      enable = true;
      systemdTarget = "sway-session.target";
      settings = [
        {
          profile.name = "Pixio";
          profile.outputs = [
            {
              criteria = "DP-1";
              adaptiveSync = true;
              mode = "3840x2160@160Hz";
              scale = 1.0;
              position = "2560,0";
            }
          ];
      }
      {
        profile.name = "Acer+Pixio";
        profile.outputs = [
        {
        criteria = "DP-1";
        adaptiveSync = true;
        mode = "3840x2160@160Hz";
        scale = 1.5;
        position = "2560,0";
        }
        {
        criteria = "DP-2";
        adaptiveSync = true;
        mode = "2560x1440@165Hz";
        position = "0,0";
            }
          ];
        #given by 'swaymsg -t get_outputs'
      } ];
    };
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
      rustup
      # discord
      vesktop
      dotacat
      grimblast
      libnotify
      autotiling-rs
      pavucontrol
      tailwindcss
      brightnessctl
      via
      protonup
      rofimoji
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
