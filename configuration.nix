{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./home-manager.nix ];

  time = { timeZone = "America/Eastern"; };

  i18n = { defaultLocale = "en_US.UTF-8"; };

  boot = {
    loader = {
      systemd-boot = { enable = true; };
      efi = { canTouchEfiVariables = true; };
    };
  };

  networking = {
    hostName = "fogCanyon";
    networkmanager = { enable = true; };
    useDHCP = false;
    interfaces = {
      enp2s0 = { useDHCP = true; };
      wlp3s0 = { useDHCP = true; };
    };
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  users = {
    defaultUserShell = pkgs.nushell;
    users.v = {
      isNormalUser = true;
      description = "v";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        cargo
        neovim
        rustup
      ];
    };
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  hardware = {
    opengl = { enable = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      vim
      dbus
      sway
      wget
      mako
      clang
      emacs
      gitui
      bemenu
      zellij
      nushell
      wayland
      swaylock
      swayidle
      alacritty
      wdisplays
      xdg-utils
      wl-clipboard
      dracula-theme
    ];
  };

  programs = {
    mtr = { enable = true; };
    sway = {
      enable = true;
      wrapperFeatures = { gtk = true; };
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    thunar = { enable = true; };
    thefuck = { enable = true; };
    xwayland = { enable = true; };
  };

  services = {
    dbus = { enable = true; };
    gnome = {
      gnome-keyring = { enable = true; };
    };
    openssh = { enable = true; };
    pipewire = {
      enable = true;
      alsa = { enable = true; };
      pulse = { enable = true; };
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr = { enable = true; };
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  system.stateVersion = "23.11";

}
