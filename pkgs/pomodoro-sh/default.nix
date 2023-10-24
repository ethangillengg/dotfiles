{
  lib,
  stdenv,
  makeWrapper,
  timer,
  libnotify,
  wl-clipboard,
  findutils,
  coreutils,
}:
with lib;
  stdenv.mkDerivation {
    name = "pomodoro-sh";
    version = "1.0";
    src = ./pomodoro.sh;

    nativeBuildInputs = [makeWrapper];

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      install -Dm 0755 $src $out/bin/pomodoro-sh
      wrapProgram $out/bin/pomodoro-sh --set PATH \
        "${
        makeBinPath [
          timer
          libnotify
          wl-clipboard
          findutils
          coreutils
        ]
      }"
    '';

    meta = {
      description = "A repeating pomodoro timer";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
