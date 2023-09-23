{
  lib,
  stdenv,
  makeWrapper,
  jq,
  curl,
}:
with lib;
  stdenv.mkDerivation {
    name = "quote";
    version = "1.0";
    src = ./quote.sh;

    nativeBuildInputs = [makeWrapper];

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      install -Dm 0755 $src $out/bin/quote
      wrapProgram $out/bin/quote --set PATH \
        "${
        makeBinPath [
          curl
          jq
        ]
      }"
    '';

    meta = {
      description = "Fetch a quote from https://api.quotable.io and print it";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
