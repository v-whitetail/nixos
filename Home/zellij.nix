{
  pkgs,
  config,
  inputs,
  home-manager,
  ...
}:

let
  palette = config.colorScheme.palette;
in 
{
  programs.zellij = {
    enable = true;
    settings = {
      copy_command  = "wl-copy";
      default_shell = "nu";
      theme = "nix-colors";
      themes.nix-colors.black   = "#${palette.base00}";
      themes.nix-colors.bg      = "#${palette.base01}";
      themes.nix-colors.fg      = "#${palette.base05}";
      themes.nix-colors.white   = "#${palette.base07}";
      themes.nix-colors.red     = "#${palette.base08}";
      themes.nix-colors.orange  = "#${palette.base09}";
      themes.nix-colors.yellow  = "#${palette.base0A}";
      themes.nix-colors.green   = "#${palette.base0B}";
      themes.nix-colors.cyan    = "#${palette.base0C}";
      themes.nix-colors.blue    = "#${palette.base0D}";
      themes.nix-colors.magenta = "#${palette.base0E}";
      ui.pane_frames.rounded_corners = true;
      keybinds = {
        shared = {
          "unbind \"Ctrl g\"" = [];
          "unbind \"Ctrl p\"" = [];
          "unbind \"Ctrl t\"" = [];
          "unbind \"Ctrl n\"" = [];
          "unbind \"Ctrl h\"" = [];
          "unbind \"Ctrl s\"" = [];
          "unbind \"Ctrl o\"" = [];
          "unbind \"Ctrl q\"" = [];
        };
        normal = {
          "bind \"Alt t\"" = { SwitchToMode =     "tab"; };
          "bind \"Alt p\"" = { SwitchToMode =    "pane"; };
          "bind \"Alt h\"" = { SwitchToMode =    "move"; };
          "bind \"Alt g\"" = { SwitchToMode =  "locked"; };
          "bind \"Alt n\"" = { SwitchToMode =  "resize"; };
          "bind \"Alt s\"" = { SwitchToMode =  "search"; };
          "bind \"Alt o\"" = { SwitchToMode = "session"; };
          "bind \"Alt q\"" = {         Quit =        []; };
        };
        tab     = { "bind \"Alt t\"" = { SwitchToMode = "normal"; }; };
        move    = { "bind \"Alt h\"" = { SwitchToMode = "normal"; }; };
        pane    = { "bind \"Alt p\"" = { SwitchToMode = "normal"; }; };
        locked  = { "bind \"Alt g\"" = { SwitchToMode = "normal"; }; };
        resize  = { "bind \"Alt n\"" = { SwitchToMode = "normal"; }; };
        search  = { "bind \"Alt s\"" = { SwitchToMode = "normal"; }; };
        session = { "bind \"Alt o\"" = { SwitchToMode = "normal"; }; };
      };
    };
  };
}
