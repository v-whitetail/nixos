{ ... }:

{
  services.shikane = {
    enable = true;
    # systemdTarget = "sway-session.target";
    settings = {
      profile = [
        {
          name = "Pixio";
          output = [
            {
              match = "DP-1";
              enable = true;
              adaptiveSync = true;
              mode = "3840x2160@160Hz";
              scale = 1.0;
              position = {
                x = 2560;
                y = 0;
              };
            }
          ];
        }
        {
          name = "Acer+Pixio";
          output = [
            {
              match = "DP-1";
              enable = true;
              adaptiveSync = true;
              mode = "3840x2160@160Hz";
              scale = 1.5;
              position = {
                x = 2560;
                y = 0;
              };
            }
            {
              match = "DP-2";
              enable = true;
              adaptiveSync = true;
              mode = "2560x1440@165Hz";
              position = {
                x = 0;
                y = 0;
              };
            }
          ];
        }
        {
          name = "Acer+Asus+Pixio1";
          output = [
            {
              match = "DP-1";
              enable = true;
              adaptiveSync = true;
              mode = "3840x2160@160Hz";
              scale = 1.0;
              position = {
                x = 2560;
                y = 690;
              };
            }
            {
              match = "DP-2";
              enable = true;
              adaptiveSync = true;
              mode = "2560x1440@165Hz";
              position = {
                x = 0;
                y = 0;
              };
            }
            {
              match = "HDMI-A-1";
              enable = true;
              adaptiveSync = false;
              mode = "1920x1080@60Hz";
              position = {
                x = 640;
                y = 1440;
              };
            }
          ];
        }
        {
          name = "Acer+Asus+Pixio2";
          output = [
            {
              match = "DP-1";
              enable = true;
              adaptiveSync = true;
              mode = "3840x2160@160Hz";
              scale = 1.0;
              position = {
                x = 2560;
                y = 690;
              };
            }
            {
              match = "DP-2";
              enable = true;
              adaptiveSync = true;
              mode = "2560x1440@165Hz";
              position = {
                x = 0;
                y = 0;
              };
            }
            {
              match = "HDMI-A-1";
              enable = true;
              adaptiveSync = false;
              mode = "1920x1080@60Hz";
              position = {
                x = 640;
                y = 1440;
              };
            }
          ];
        }
      ];
    };
  };
}
