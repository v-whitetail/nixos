{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};

    packages = with pkgs; [
      zellij
      tailwindcss
    ];
  in
  {
    devShell = pkgs.mkShell {
      buildInputs = packages;

      shellHook = ''
      cargo install live-server
      nu -c "zellij -l dev.kdl"
      exit
      '';
    };
  });
}
