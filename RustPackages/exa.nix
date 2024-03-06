{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "exa";
  owner = "ogham";
  version = "0.10.1";

  src = fetchCrate {
    inherit pname version;
    hash = lib.fakeSha256;
  };

  cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "A modern replacement for ls";
    homepage = "https://github.com/ogham/exa";
  };
}
