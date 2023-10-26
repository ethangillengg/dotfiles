{
  lib,
  stdenv,
  makeWrapper,
  ripgrep,
  fzf,
  gnused,
  poppler_utils,
  zathura,
}:
with lib;
  stdenv.mkDerivation {
    name = "pdfsearch";
    version = "1.0";
    src = ./pdfsearch.sh;

    nativeBuildInputs = [makeWrapper];

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      install -Dm 0755 $src $out/bin/pdfsearch
      wrapProgram $out/bin/pdfsearch --set PATH \
        "${
        makeBinPath [
          fzf
          ripgrep
          ripgrep-all
          gnused
          poppler_utils
          zathura
        ]
      }"
    '';

    meta = {
      description = "Interactively search pdfs using fzf and ripgrep!";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
