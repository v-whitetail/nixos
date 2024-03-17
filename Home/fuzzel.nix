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
  programs.fuzzel = {
    enable = true;
    settings = {
  	main.prompt = "<&'i str>" ;
  	border.radius = 2;
  	colors = {
  	  background      = "${palette.base00}AA";
  	  border          = "${palette.base07}FF";
  	  text            = "${palette.base07}AA";
  	  match           = "${palette.base0B}FF";
  	  selection       = "${palette.base0A}44";
  	  selection-text  = "${palette.base0C}FF";
  	  selection-match = "${palette.base0D}FF";
  	};
    };
  };
}
