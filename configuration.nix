{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  time.timeZone = "US/Eastern";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  boot = {
    plymouth.enable = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    opengl.enable = true;
    trackpoint.enable = true;
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users = {
      v = {
        isNormalUser = true;
        description = "v-whitetail";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [ ];
      };
    };
  };

  networking = {
    hostName = "fogCanyon";
    useDHCP = false;
    interfaces = {
      enp2s0 = { useDHCP = true; };
      wlp3s0 = { useDHCP = true; };
    };
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      fzf
      gcc
      git
      vim
      dbus
      sway
      wget
      gitui
      rustc
      cargo
      nushell
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };

  security = {
    polkit.enable = true;
  };

  programs = {
    mtr.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    xwayland.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  services = {
    ntp.enable = true;
    dbus.enable = true;
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      libinput.enable = true;
      xkb = {
	variant = "";
	layout = "us";
      };
      displayManager.sddm = {
	enable = true;
	autoNumlock = true;
	wayland.enable = true;
	theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      };
    };
  };

  system = { stateVersion = "23.11"; };

}
