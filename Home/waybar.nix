{
  config,
  ...
}:

let
  palette = config.colorScheme.palette;
  d_task = "btm";
  d_term = "foot";
  d_font = "Maple Mono NF";
in 
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "bottom";
      height = 24;
      modules-left = [
        "sway/workspaces" "sway/mode" "sway/window"
      ];
      modules-right = [
        "tray" "cpu" "memory" "pulseaudio"
        "network" "clock" 
        "custom/screenshot" "custom/logout" "custom/power"
      ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "sway/window" = {
        format = "{}";
      };
      "tray" = {
        icon-size = 14;
        spacing = 5;
      };
      "clock" = {
        tooltip-format = "{:%A %B %d %Y | %H:%M}";
        format = " {:%a %d %b  %I:%M %p}";
        format-alt = " {:%d/%m/%Y  %H:%M:%S}";
        interval = 1;
      };
      "cpu" = {
        format = "{usage: >3}%";
        on-click = "${d_term} -e ${d_task}";
      };
      "memory" = {
        format = "{: >3}%";
        on-click = "${d_term} -e ${d_task}";
      };
      "network" = {
        format = "⚠ Disabled";
        format-wifi = " {essid}";
        format-ethernet = " {ifname}: {ipaddr}/{cidr}";
        format-disconnected = "⚠ Disconnected";
        on-click = "${d_term} -e nmtui";
      };
      "pulseaudio" = {
        scroll-step = 1;
        format = "{icon} {volume: >3}%";
        format-bluetooth = "{icon} {volume: >3}%";
        format-muted =" muted";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" ""];
        };
        on-click = "pavucontrol";
      };
      "custom/screenshot" = {
        format = "󰄄";
        on-click = "grimblast copy area";
        tooltip = false;
      };
      "custom/logout" = {
        format = "";
        on-click = "swaymsg exit";
        tooltip = false;
      };
      "custom/power" = {
        format ="⏻";
        on-click = "systemctl suspend";
        tooltip = false;
      };
    }];
    style = 
    ''
      * {
          color: #${palette.base05};
          border: 0px;
          border-radius: 0px;
          padding: 0px 0px;
          font-family: ${d_font};
          font-size: 16px;
          margin-right: 4px;
          margin-left: 4px;
          padding-bottom: 2px;
         }
      window#waybar {
          background: transparent;
      }
      #workspaces button {
          padding: 2px 8px;
          border-style: solid;
          border-bottom: 4px;
          border-radius: 4px 16px;
          color: #${palette.base05};
          background: #${palette.base01};
      }
      #workspaces button.focused {
          color: #${palette.base08};
      }
      #mode {
          color: #${palette.base05};
      }
      #clock, #cpu, #memory, #temperature,
      #network, #pulseaudio, #mode, #tray, #window,
      #custom-logout, #custom-power, #custom-screenshot
      {
          padding: 2px 8px;
          border-bottom: 4px;
          border-style: solid;
          border-radius: 4px 16px;
          background: #${palette.base01};
      }
      #custom-power,
      #custom-logout,
      #custom-screenshot {
          padding: 2px 16px;
          font-size: 20px;
          border-style: solid;
          border-bottom: 4px;
          color: #${palette.base0F};
      }
      #clock { color:#${palette.base0D}; }
      #cpu { color:#${palette.base08}; }
      #memory { color: #${palette.base09}; }
      #network { color: #${palette.base0C}; }
      #network.disabled { color: #${palette.base03}; }
      #network.disconnected { color: #${palette.base05}; }
      #pulseaudio { color: #${palette.base0B}; }
      #pulseaudio.muted { color: #${palette.base03}; }
    '';
  };
}
