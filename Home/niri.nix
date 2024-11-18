{
  inputs,
  ...
}: {
  options.app.niri.enable = true;

  config = {
    programs.niri = {
      enable = true;
    };
  };
}
