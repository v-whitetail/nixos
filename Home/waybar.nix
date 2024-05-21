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
        "tray" "cpu" "memory" "backlight" "pulseaudio"
        "network" "clock" "battery"
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
      "backlight" = {
        format = "{icon} {percent: >3}%";
        format-icons = ["" ""];
        on-scroll-down = "brightnessctl -c backlight set 1%-";
        on-scroll-up = "brightnessctl -c backlight set +1%";
      };
      "battery" = {
        states = {
          warning = 25;
          critical = 15;
        };
        format = "{icon} {capacity: >3}%";
        format-icons = ["" "" "" "" ""];
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
        on-click = "nwgbar";
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
          background: #${palette.base01};
          opacity: 0.90;
      }
      #workspaces button {
          padding: 4px 0px 2px 0px;
          border-bottom: 2px;
          color: #${palette.base05};
          border-color: #${palette.base05};
          border-style: solid;
          margin-top:2px;
      }
      #workspaces button.focused {
          color: #${palette.base08};
          border-color: #${palette.base08};
      }
      #mode {
          color: #${palette.base05};
          margin-bottom: 3px;
      }
      #clock, #battery, #cpu, #memory, #temperature, #backlight,
      #network, #pulseaudio, #mode, #tray, #window,
      #custom-power, #custom-power, #custom-screenshot
      {
          padding: 2px 2px;
          border-bottom: 2px;
          border-style: solid;
      }
      #custom-power,
      #custom-logout,
      #custom-screenshot {
          font-size: 20px;
          border-style: hidden;
          padding: 2px 4px;
          color: #${palette.base0F};
      }
      #clock { color:#${palette.base0D}; }
      #backlight { color: #${palette.base0A}; }
      #battery { color: #${palette.base0E}; }
      #battery.charging { color: #${palette.base0B}; }
      @keyframes blink {
          to {
              color: #${palette.base07};
              background-color: #${palette.base03};
          }
      }
      #battery.critical:not(.charging) {
          background: #${palette.base0E};
          color: #${palette.base08};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      #cpu { color:#${palette.base08}; }
      #memory { color: #${palette.base09}; }
      #network { color: #${palette.base0C}; }
      #network.disabled { color: #${palette.base03}; }
      #network.disconnected { color: #${palette.base05}; }
      #pulseaudio { color: #${palette.base0B}; }
      #pulseaudio.muted { color: #${palette.base03}; }
      #window{
          border-style: hidden;
          margin-top:1px;  
      }    
    '';
  };
}
