{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  time = { timeZone = "America/Eastern"; };

  i18n = { defaultLocale = "en_US.UTF-8"; };

  boot = {
    loader = {
      systemd-boot = { enable = true; };
      efi = { canTouchEfiVariables = true; };
    };
    plymouth = { enable = true; };
  };

  hardware = {
    opengl = { enable = true; };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users = {
      v = {
        isNormalUser = true;
        description = "v";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [ ];
      };
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

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      vim
      dbus
      sway
      wget
      gitui
      nushell
      wayland
    ];
  };

  security = {
    polkit = { enable = true; };
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
    xwayland = { enable = true; };
  };

  xdg = {
    portal = {
      enable = true;
      wlr = { enable = true; };
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
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
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
	      --time \
	      --user-menu \
	      --asterisks \
	      --cmd sway
	      '';
	};
      };
    };
  };

  system = { stateVersion = "23.11"; };

}
