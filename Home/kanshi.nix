{ ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "sway-session.target";
    settings = [
      {
        profile.name = "Pixio";
        profile.outputs = [
          {
            criteria = "DP-1";
            adaptiveSync = true;
            mode = "3840x2160@160Hz";
            scale = 1.0;
            position = "2560,0";
          }
        ];
      }
      {
        profile.name = "Acer+Pixio";
        profile.outputs = [
          {
            criteria = "DP-1";
            adaptiveSync = true;
            mode = "3840x2160@160Hz";
            scale = 1.5;
            position = "2560,0";
          }
          {
            criteria = "DP-2";
            adaptiveSync = true;
            mode = "2560x1440@165Hz";
            position = "0,0";
          }
        ]; #given by 'swaymsg -t get_outputs'
      }
      {
        profile.name = "Acer+Asus+Pixio";
        profile.outputs = [
          {
            criteria = "DP-1";
            adaptiveSync = true;
            mode = "3840x2160@160Hz";
            scale = 1.5;
            position = "2560,690";
          }
          {
            criteria = "DP-2";
            adaptiveSync = true;
            mode = "2560x1440@165Hz";
            position = "0,0";
          }
          {
            criteria = "HDMI-A-1";
            adaptiveSync = false;
            mode = "1920x1080@60Hz";
            position = "640,1440";
          }
        ]; #positions can be fine tuned with wdisplays
      }
    ];
  };
}
