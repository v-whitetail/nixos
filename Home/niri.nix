{
  ...
}: {
  programs.niri.enable = true;
  programs.niri.settings = {
    layout = {
      gaps = 16;
      struts.left = 64;
      struts.right = 64;
      border.width = 4;
      always-center-single-column = true;
    };
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";
  };
}
