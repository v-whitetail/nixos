{
  pkgs,
  config,
  inputs,
  home-manager,
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
  d_brow = "firefox";
  d_font = "Maple Mono NF";
in 
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${d_font}:size=10";
        font-bold = "${d_font}:style=Bold:size=10";
        font-italic = "${d_font}:style=Italic:size=10";
        font-bold-italic = "${d_font}:style=BoldItalic:size=10";
        line-height="11";
      };
      colors = {
        alpha = 0.90;
        background = "${palette.base01}";
        foreground = "${palette.base06}";
        bright0    = "${palette.base00}";
        bright7    = "${palette.base07}";
        bright1    = "${palette.base08}";
        bright3    = "${palette.base0A}";
        bright2    = "${palette.base0B}";
        bright6    = "${palette.base0C}";
        bright4    = "${palette.base0D}";
        bright5    = "${palette.base0E}";
        regular0   = "${palette.base00}";
        regular7   = "${palette.base07}";
        regular1   = "${palette.base08}";
        regular3   = "${palette.base0A}";
        regular2   = "${palette.base0B}";
        regular6   = "${palette.base0C}";
        regular4   = "${palette.base0D}";
        regular5   = "${palette.base0E}";
      };
    };
  };
}
