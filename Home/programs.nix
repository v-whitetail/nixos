{
  ...
}:

{
  services.wpaperd = {
    enable = true;
    settings.default.path = "/home/v/Pictures/Wallpapers";
    settings.default.sorting = "random";
    settings.default.duration = "30m";
  };
  programs = {
    gh.enable = true;
    bat.enable = true;
    lsd.enable = true;
    imv.enable = true;
    fzf.enable = true;
    gitui.enable = true;
    swayr.enable = true;
    bottom.enable = true;
    ripgrep.enable = true;
    firefox.enable = true;
    swaylock.enable = true;
    librewolf.enable = true;
    home-manager.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    nushell = { 
      enable = true;
      envFile.source    = ./DotFiles/env.nu;
      configFile.source = ./DotFiles/config.nu;
    };
    git = {
      enable = true;
      userName  = "v-whitetail";
      userEmail = "white.tail.millwork@gmail.com";
      ignores   = [ "*.swp" "*.swo" ];
    };
  };
}
