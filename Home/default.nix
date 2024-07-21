{
  pkgs,
  inputs,
  nixvirt,
  ...
}:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nixvirt.homeModules.default
    ./foot.nix
    ./sway.nix
    ./fuzzel.nix
    ./nixvim.nix
    ./waybar.nix
    ./zellij.nix
    ./programs.nix
    ./swaylock.nix
  ];

  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.connections."qemu:///session".domains = [{
    definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows {
      name = "Wendys";
      uuid = "bf032124-7a3e-456d-850a-84a8e74d4485";
      memory = { count = 8; unit = "GiB"; };
      storage_vol = { pool = "MyPool"; volume = "Wendys.qcow2"; };
      install_vol = /home/v/VM/Win11_23H2_English_x64v2.iso;
      nvram_path = /home/v/VM/Wendys.nvram;
      virtio_net = true;
      virtio_drive = true;
      install_virtio = true;
    });
  }];

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
    kanshi = {
      enable = true;
      systemdTarget = "sway-session.target";
      settings = [ {
        profile.name = "undocked";
        profile.outputs = [ {
          criteria = "eDP-1";
        } ];
      } {
        profile.name = "fogCanyon";
        profile.outputs = [ {
          criteria = "Acer Technologies XB271HU A #ASOCIiJmrKvd";
          adaptiveSync = true;
          position = "1920,0";
          mode = "2560x1440@165Hz";
        } {
          criteria = "Ancor Communications Inc ASUS VS228 D9LMTF088670";
          adaptiveSync = false;
          position = "0,420";
        } ];
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
      wtwitch
      vlc
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
