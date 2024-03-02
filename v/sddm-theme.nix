inputs.sddm-catppuccin.url = "github:khaneliman/sddm-catppuccin";
inputs.sddm-catppuccin.inputs.nixpkgs.follows = "nixpkgs";

...

inputs.sddm-catppuccin.packages.${pkgs.hostPlatform.system}.sddm-catppuccin

...

services.xserver = {
  enable = true;

  libinput.enable = true;
  displayManager = {
    sddm = {
      enable = true;
      theme = "catppuccin";
    };
  };
};

