{
  lib,
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
  m_key = "SUPER";
  d_man = "yazi";
  d_task = "btm";
  d_term = "foot";
  d_menu = "fuzzel";
  d_brow = "librewolf";
  d_font = "Maple Mono NF";
in 
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };

    settings = {
      input = {
        follow_mouse = true;
        numlock_by_default = true;
      };
      general = {
        layout = "master";
        gaps_in = 8;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgb(${palette.base08}) rgb(${palette.base0F}) 45 deg";
        "col.inactive_border" = "rgb(${palette.base0B}) rgb(${palette.base0C}) 45 deg";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };
      misc = {
        vfr = true;
        vrr = 1;  #sets adaptive sync always on
        enable_swallow = false;
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        disable_splash_rendering = true;
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        mfact = 0.5;
        new_on_top = true;
        new_status = "slave";
      };
      cursor = {
        no_warps = true;
        no_hardware_cursors = 2;
        enable_hyprcursor = false;
        sync_gsettings_theme = true;
        warp_on_change_workspace = 2;
      };
      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q wpaperd;sleep .5 && wpaperd"
        "killall -q waybar;sleep .5 && waybar"
        "killall -q mako;sleep .5 && mako"
        "nm-applet --indicator"
        "lxqt-policykit-agent"
      ];
      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "EDITOR,nvim"
      ];
      bind = [
        "${m_key},Return,exec,${d_term}"
        "${m_key},i,exec,${d_brow}"
        "${m_key},d,exec,${d_menu}"
        "${m_key},f,fullscreen,"
        "${m_key},q,killactive,"
        "${m_key},s,togglesplit,"
        "${m_key},${u_key},movefocus,u"
        "${m_key},${d_key},movefocus,d"
        "${m_key},${l_key},movefocus,l"
        "${m_key},${r_key},movefocus,r"
        "${m_key},1,workspace,1"
        "${m_key},2,workspace,2"
        "${m_key},3,workspace,3"
        "${m_key},4,workspace,4"
        "${m_key},5,workspace,5"
        "${m_key},6,workspace,6"
        "${m_key},7,workspace,7"
        "${m_key},8,workspace,8"
        "${m_key},9,workspace,9"
        "${m_key},0,workspace,10"
        "${m_key} SHIFT,${u_key},movewindow,u"
        "${m_key} SHIFT,${d_key},movewindow,d"
        "${m_key} SHIFT,${l_key},movewindow,l"
        "${m_key} SHIFT,${r_key},movewindow,r"
        "${m_key} SHIFT,1,movetoworkspace,1"
        "${m_key} SHIFT,2,movetoworkspace,2"
        "${m_key} SHIFT,3,movetoworkspace,3"
        "${m_key} SHIFT,4,movetoworkspace,4"
        "${m_key} SHIFT,5,movetoworkspace,5"
        "${m_key} SHIFT,6,movetoworkspace,6"
        "${m_key} SHIFT,7,movetoworkspace,7"
        "${m_key} SHIFT,8,movetoworkspace,8"
        "${m_key} SHIFT,9,movetoworkspace,9"
        "${m_key} SHIFT,0,movetoworkspace,10"
        "${m_key} SHIFT,Space,togglefloating,"
        "${m_key} Control_L,${u_key},resizeactive, 64 0"
        "${m_key} Control_L,${d_key},resizeactive,-64 0"
        "${m_key} Control_L,${l_key},resizeactive,0 -64"
        "${m_key} Control_L,${r_key},resizeactive,0  64"
      ];
    };
    extraConfig = lib.concatStrings [
      ''
      ''
    ];
  };
}
