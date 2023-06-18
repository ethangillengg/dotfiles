{
  outputs,
  inputs,
}: {
  # Adds my custom packages
  additions = final: prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # use lf-sixel for sixel image previews in wezterm
    lf = prev.lf.overrideAttrs (oldAttrs: {
      pname = "lf";
      # version = "custom"; # set the version to something that makes sense for you
      src = final.fetchFromGitHub {
        owner = "horriblename";
        repo = "lf";
        rev = "master"; # set the revision to the commit hash or tag you want
        sha256 = "sha256-cQf+OP1u6lf/7QgT/Rg9613Igx4YjqEUchmjsk31Z8c="; # replace this with the correct sha256 hash
      };
    });

    osu-lazer-bin = let
      version = "2023.617.0";
    in
      prev.callPackage (
        {
          lib,
          stdenv,
          fetchurl,
          fetchzip,
          appimageTools,
        }: let
          pname = "osu-lazer-bin";
          name = "${pname}-${version}";

          osu-lazer-bin-src = {
            url = "https://github.com/ppy/osu/releases/download/${version}/osu.AppImage";
            sha256 = "sha256-g/jBY7L06PrIHQ/2W52Itr+BkKIXEaYIHzyVMZHcrkk=";
          };
        in
          appimageTools.wrapType2 rec {
            inherit name pname version;

            src = fetchurl osu-lazer-bin-src;

            extraPkgs = pkgs: with pkgs; [icu];

            extraInstallCommands = let
              contents = appimageTools.extract {inherit pname version src;};
            in ''
              mv -v $out/bin/${pname}-${version} $out/bin/osu\!
              install -m 444 -D ${contents}/osu\!.desktop -t $out/share/applications
              for i in 16 32 48 64 96 128 256 512 1024; do
                install -D ${contents}/osu\!.png $out/share/icons/hicolor/''${i}x$i/apps/osu\!.png
              done
            '';
          }
      ) {};
  };
}
