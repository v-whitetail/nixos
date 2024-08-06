{
  pkgs,
  config,
  ...
}:

let
  palette = config.colorScheme.palette;
  d_key = "j";
  u_key = "k";
  l_key = "h";
  r_key = "l";
  m_key = "Mod4";
  d_man = "yazi";
  d_task = "btm";
  d_term = "foot";
  d_menu = "fuzzel";
  d_brow = "librewolf";
  d_font = "Maple Mono NF";
in 
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      input."*" = {
        tap = "enabled";
        drag = "enabled";
        drag_lock = "enabled";
        tap_button_map = "lrm";
      };
      bars = [{
        id = "default_waybar";
        command = "waybar";
      }];
      startup = [
        { command = "wpaperd"; always = true; }
        { command = "autotiling-rs"; always = true; }
      ];
      modifier = m_key;
      left     = l_key;
      right    = r_key;
      up       = u_key;
      down     = d_key;
      terminal = d_term;
      menu     = d_menu;
      window.titlebar = false;
      defaultWorkspace = "workspace number 1";
      gaps = {
        left       = 8;
        right      = 8;
        top        = 8;
        bottom     = 8;
        inner      = 8;
        outer      = 8;
        vertical   = 8;
        horizontal = 8;
      };
      colors = {
        background    = "#${palette.base00}";
        focused = {
          background  = "#${palette.base01}";
          text        = "#${palette.base07}";
          border      = "#${palette.base0F}";
          indicator   = "#${palette.base0F}";
          childBorder = "#${palette.base0F}";
        };
        focusedInactive = {
          background  = "#${palette.base01}";
          text        = "#${palette.base07}";
          border      = "#${palette.base0D}";
          indicator   = "#${palette.base0D}";
          childBorder = "#${palette.base0D}";
        };
        unfocused = {
          background  = "#${palette.base01}";
          text        = "#${palette.base07}";
          border      = "#${palette.base0C}";
          indicator   = "#${palette.base0C}";
          childBorder = "#${palette.base0C}";
        };
        placeholder = {
          background  = "#${palette.base01}";
          text        = "#${palette.base07}";
          border      = "#${palette.base0B}";
          indicator   = "#${palette.base0B}";
          childBorder = "#${palette.base0B}";
        };
        urgent = {
          text        = "#${palette.base08}";
          border      = "#${palette.base08}";
          indicator   = "#${palette.base08}";
          background  = "#${palette.base08}";
          childBorder = "#${palette.base08}";
        };
      };
      keybindings = with pkgs; {
        "${m_key}+p" = "exec nu -c \""
            + "pkill wpaperd; wpaperd -d;"
            + "pkill waybar; swaymsg exec waybar\"";
        "${m_key}+Return" = "exec ${d_term}";
        "${m_key}+d" = "exec ${d_menu}";
        "${m_key}+i" = "exec ${d_brow}";
        "${m_key}+e" = "exec ${d_man}";
        "${m_key}+q" = "kill";
        "${m_key}+b" = "splith";
        "${m_key}+v" = "splitv";
        "${m_key}+f" = "fullscreen";
        "${m_key}+s" = "layout toggle split";
        "${m_key}+Shift+space" = "floating toggle";
        "${m_key}+${u_key}" = "focus up";
        "${m_key}+${d_key}" = "focus down";
        "${m_key}+${l_key}" = "focus left";
        "${m_key}+${r_key}" = "focus right";
        "${m_key}+Shift+${u_key}" = "move up";
        "${m_key}+Shift+${d_key}" = "move down";
        "${m_key}+Shift+${l_key}" = "move left";
        "${m_key}+Shift+${r_key}" = "move right";
        "${m_key}+1" = "workspace number 1";
        "${m_key}+2" = "workspace number 2";
        "${m_key}+3" = "workspace number 3";
        "${m_key}+4" = "workspace number 4";
        "${m_key}+5" = "workspace number 5";
        "${m_key}+6" = "workspace number 6";
        "${m_key}+7" = "workspace number 7";
        "${m_key}+8" = "workspace number 8";
        "${m_key}+9" = "workspace number 9";
        "${m_key}+0" = "workspace number 10";
        "${m_key}+Shift+1" = "move container to workspace number 1";
        "${m_key}+Shift+2" = "move container to workspace number 2";
        "${m_key}+Shift+3" = "move container to workspace number 3";
        "${m_key}+Shift+4" = "move container to workspace number 4";
        "${m_key}+Shift+5" = "move container to workspace number 5";
        "${m_key}+Shift+6" = "move container to workspace number 6";
        "${m_key}+Shift+7" = "move container to workspace number 7";
        "${m_key}+Shift+8" = "move container to workspace number 8";
        "${m_key}+Shift+9" = "move container to workspace number 9";
        "${m_key}+Shift+0" = "move container to workspace number 10";
      };
    };
  };
}
