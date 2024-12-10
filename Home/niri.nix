{
  config,
  inputs,
  ...
}: {
  imports = [ inputs.niri.homeModules.niri ];

  options.app.niri.enable = true;

  config = {
    programs.niri = {
      enable = true;
      settings = {

        input.keyboard.xkb.layout = "no";

        prefer-no-csd = true;

        layout = {
          gaps = 16;
          struts.left = 64;
          struts.right = 64;
          border.width = 4;
          always-center-single-column = false;
          preset-column-widths = [
            { proportion = 1.0 / 1.0; }
            { proportion = 1.0 / 2.0; }
            { proportion = 1.0 / 3.0; }
            { proportion = 2.0 / 3.0; }
            { proportion = 1.0 / 4.0; }
            { proportion = 3.0 / 4.0; }
          ];
          default-column-width = { proportion = 1.0 / 2.0; };
        };

        spawn-at-startup = [
          { command = [ "waybar"  ]; }
          { command = [ "wpaperd" ]; }
        ];

        binds = with config.lib.niri.actions; {


          "Mod+i".action = spawn "librewolf";
          "Mod+d".action = spawn "fuzzel";
          "Mod+Return".action = spawn "foot";

          "Mod+q".action = close-window;
          "Mod+g".action = show-hotkey-overlay;
          "Mod+shift+Q".action = quit;

          "Mod+0".action = focus-workspace 0;
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;

        };
      };
    };
  };
}
