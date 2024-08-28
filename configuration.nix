{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelParams = [ "splash" ];

  time.timeZone = "US/Eastern";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # hardware.graphics.enable = true;

  networking = {
    hostName = "queensGarden";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 42069 ];
    firewall.allowedUDPPorts = [ 22 42069 ];
  };

  users = {
    # defaultUserShell = pkgs.nushell;
    users = {
      v = {
        isNormalUser = true;
        description = "v-whitetail";
        extraGroups = [ "networkmanager" "wheel" ];
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

  # security = {
  #   polkit.enable = true;
  # };

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    getty.autologinUser = "v";
  };

  system = { stateVersion = "23.11"; };

}
