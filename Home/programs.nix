{
  pkgs,
  ...
}:

{
  programs = {
    gh.enable = true;
    bat.enable = true;
    lsd.enable = true;
    imv.enable = true;
    fzf.enable = true;
    rio.enable = true;
    gitui.enable = true;
    swayr.enable = true;
    bottom.enable = true;
    firefox.enable = true;
    ripgrep.enable = true;
    swaylock.enable = true;
    home-manager.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    wpaperd = {
      enable = true;
      settings.default.path = "/home/v/Pictures/Wallpapers";
      settings.default.sorting = "random";
      settings.default.duration = "30m";
    };
    nushell = { 
      enable = true;
      envFile.source    = ./DotFiles/env.nu;
      configFile.source = ./DotFiles/config.nu;
      # extraEnv = ''
      #   $env.LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ pkgs.openssl_3 ]}/libssl.so.3"
      # '';
    };
    git = {
      enable = true;
      userName  = "v-whitetail";
      userEmail = "white.tail.millwork@gmail.com";
      ignores   = [ "*.swp" "*.swo" ];
    };
  };
}
