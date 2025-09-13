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
    graphics.enable = true;
    bluetooth.enable = true;
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
      };
    };
  };

  networking = {
    hostName = "fogCanyon";
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      fd
      fzf
      gcc
      git
      dbus
      sway
      wget
      gitui
      neovim
      nushell
      bluetuith
    ];
  };

  security = {
    polkit.enable = true;
  };

  programs = {
    mtr.enable = true;
    sway.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    xwayland.enable = true;
  };

  services = {
    ntp.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    postgresql.enable = true;
    gnome.gnome-keyring.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    # xserver = {
    #   enable = true;
    #   xkb = {
    #     variant = "";
    #     layout = "us";
    #   };
    # };
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        tappingDragLock = true;
        tappingButtonMap = "lrm";
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      extraPackages = with pkgs; [
        libsForQt5.qt5.qtsvg
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
      ];
      theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    };
  };

  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      maple-mono.NF
    ];
  };

  system = { stateVersion = "23.11"; };

}
