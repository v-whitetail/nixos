{ lib, config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.silentSDDM.nixosModules.default
  ];

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
      ];
    };
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "splash"
    ];
    supportedFilesystems = [
      "ntfs"
    ];
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
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
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ]; #opened for wivrn
    };
    networkmanager.enable = true;
  };

  virtualisation = {
    # docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        # ovmf = {
        #   enable = true;
        #   packages = [(pkgs.OVMF.override {
        #     secureBoot = true;
        #     tpmSupport = true;
        #   }).fd];
        # };
        # - The 'virtualisation.libvirtd.qemu.ovmf' submodule has been removed. All OVMF images distributed with QEMU are now available by default.
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
      # sway
      wget
      gitui
      # rustc
      # cargo
      neovim
      nushell
      openssl
      mangohud
      pciutils
      bluetuith
      xwayland-satellite
      lxqt.lxqt-policykit
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # xdg.portal.wlr.enable = lib.mkForce true; # NOTE REMOVE THIS IF ABLE

  programs = {
    mtr.enable = true;
    niri.enable = true;
    # sway.enable = true;
    nix-ld.enable = true;
    xwayland.enable = true;
    hyprland.enable = true;
    dconf.enable = true;
    gamemode.enable = true;
    virt-manager = {
      enable = true;
      # package = pkgs.virt-manager-qt;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
    silentSDDM = let
      padded-andre = pkgs.stdenv.mkDerivation {
        name = "andre-padded";
        src = builtins.fetchurl {
          url = "https://static1.e621.net/data/92/12/9212888c5c4816ac0d7fc2be7baa8027.webm";
          sha256 = "1nik4zjxrrr55fy3rmghlzd02qkdxjxrbfzdl68zjyga6g8xj0ms";
        };
        nativeBuildInputs = [ pkgs.ffmpeg ];
        buildCommand = ''
          mkdir -p $out
          ffmpeg -i $src -vf "pad=2*iw:ih:iw:0:black" -an $out/andre.mp4
        '';
      };
    in {
      enable = true;
      theme = "rei";
      # backgrounds."andre" = ./andre.mp4;
      backgrounds."andre" = "${padded-andre}";
      settings = {
        "LoginScreen"."background" = "andre.mp4";
        "LockScreen"."background" = "andre.mp4";
      };
    };
    # silentSDDM = "${import ./silent-sddm.nix { inherit pkgs; }}";
  };

  services = {
    # ntp.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    # postgresql.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = [ pkgs.via ];
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
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
    # desktopManager.plasma6.enable = true;
    # displayManager.defaultSession = "hyprland";
    # displayManager.sddm = {
    #   enable = true;
    #   autoNumlock = true;
    #   wayland.enable = true;
    #   extraPackages = with pkgs; [
    #     kdePackages.qtbase
    #     # qt6.qtsvg
    #     # qt6.qt5compat
    #     # qt6.qtquick3d
    #     # qt6.qtquickeffectmaker
    #     # qt6.qtvirtualkeyboard
    #     # qt6.qtgraphs
    #     # qt5.qtsvg
    #     # qt5.qtquickcontrols2
    #     # qt5.qtgraphicaleffects
    #   ];
    #   theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    # };
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
