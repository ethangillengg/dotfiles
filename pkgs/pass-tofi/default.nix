{
  lib,
  stdenv,
  makeWrapper,
  pass,
  jq,
  tofi,
  libnotify,
  wl-clipboard,
  findutils,
  gnused,
  coreutils,
}:
with lib;
  stdenv.mkDerivation {
    name = "pass-tofi";
    version = "1.0";
    src = ./pass-tofi.sh;

    nativeBuildInputs = [makeWrapper];

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      install -Dm 0755 $src $out/bin/pass-tofi
      wrapProgram $out/bin/pass-tofi --set PATH \
        "${
        makeBinPath [
          pass
          jq
          tofi
          libnotify
          wl-clipboard
          findutils
          gnused
          coreutils
        ]
      }"
    '';

    meta = {
      description = "A tofi graphical menu for pass";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
