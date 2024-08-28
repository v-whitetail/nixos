{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "splash" ];

  time.timeZone = "US/Eastern";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # hardware.graphics.enable = true;

  networking = {
    hostName = "queensGarden";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
    firewall.allowedUDPPorts = [ 22 ];
  };

  users = {
    # defaultUserShell = pkgs.nushell;
    users = {
      v = {
        isNormalUser = true;
        description = "v-whitetail";
        extraGroups = [ "networkmanager" "wheel" "libvirtd"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    fd
    gh
    git
    vim
    wget
    gitui
    pciutils
  ];

  security = {
    polkit.enable = true;
  };

  programs = {
    mtr.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
    };
    tailscale.enable = true;
  };

  system = { stateVersion = "23.11"; };

}
