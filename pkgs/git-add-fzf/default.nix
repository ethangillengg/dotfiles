{
  lib,
  stdenv,
  makeWrapper,
  fzf,
  git,
  nawk,
  delta,
}:
with lib;
  stdenv.mkDerivation {
    name = "git-add-fzf";
    version = "1.0";
    src = ./add.sh;

    nativeBuildInputs = [makeWrapper];

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      install -Dm 0755 $src $out/bin/git-add-fzf
      wrapProgram $out/bin/git-add-fzf --set PATH \
        "${
        makeBinPath [
          delta
          nawk
          git
          fzf
        ]
      }"
    '';

    meta = {
      description = "Add changes to git interactively";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
