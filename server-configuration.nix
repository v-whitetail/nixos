{ config, pkgs, lib, inputs, ... }:
{

  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      the-rice-fields-0 = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21;
        serverProperties = {
          gamemode = 1;
          difficulty = 3;
          max-players = 8;
          server-port = 42069;
          view-distance = 24;
          motd = "welcome to the rice fields";
        };
      };
    };
  };

}
