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
    initrd = {
      enable = true;
      kernelModules = [
        "amdgpu"
        # "vfio_pci"
        # "vfio"
        # "vfio_iommu_type1"
        # "nvidiafb"
        # "nouveau"
        # "snd_hda_intel"
      ];
    };
    kernelParams = [
      "splash"
      # "amd_iommu=on"
      # "iommu=pt"
      # "vfio-pci.ids=1002:744c,1002:ab30"
    ];
    supportedFilesystems = [
      "ntfs"
    ];
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
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
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      fd
      fzf
      gcc
      git
      via
      dbus
      sway
      wget
      gitui
      rustc
      cargo
      neovim
      nushell
      openssl
      mangohud
      pciutils
      bluetuith
    ];
  };

  security = {
    polkit.enable = true;
  };

  programs = {
    mtr.enable = true;
    sway.enable = true;
    nix-ld.enable = true;
    xwayland.enable = true;
    dconf.enable = true;
    gamemode.enable = true;
    virt-manager = {
      enable = true;
      # package = pkgs.virt-manager-qt;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  services = {
    # ntp.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    postgresql.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = [ pkgs.via ];
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
      videoDrivers = ["amdgpu"];
    };
    libinput = {
      enable = true;
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
      nerdfonts
      jetbrains-mono
      maple-mono-NF
    ];
  };

  system = { stateVersion = "23.11"; };

}
