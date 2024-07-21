{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  time.timeZone = "US/Eastern";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  boot = {
    initrd.enable = true;
    plymouth.enable = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
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
        extraGroups = [ "networkmanager" "wheel" "libvirtd"];
      };
    };
  };

  networking = {
    hostName = "fogCanyon";
    useDHCP = false;
    interfaces = {
      enp33s0.useDHCP = true;
      wlp37s0.useDHCP = true;
    };
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd.enable = true;
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
      rustc
      cargo
      neovim
      nushell
      openssl
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
    virt-manager.enable = true;
    dconf.enable = true;
  };

  services = {
    ntp.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    postgresql.enable = true;
    gnome.gnome-keyring.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "suspend";
      lidSwitchExternalPower = "suspend";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
    };
    libinput = {
      enable = true;
    };
    displayManager.sddm = {
      enable = true;
      autoNumlock = false;
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
      nerdfonts
      jetbrains-mono
      maple-mono-NF
    ];
  };

  system = { stateVersion = "23.11"; };

}
