{
  outputs,
  inputs,
}: {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs
      (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # use this fork since the main is broken
    # see: (https://github.com/mlvzk/manix/issues/31)
    manix = prev.manix.overrideAttrs (oldAttrs: {
      pname = "manix";
      version = "0.6.3";

      src = final.fetchFromGitHub {
        owner = "waalge";
        repo = "manix";
        rev = "ed023294d9a20786a359306f252ab2a7669fe9a9"; # set the revision to the commit hash or tag you want
        sha256 = "sha256-0UwLWHMIUT108AB+YgwVldYjQrUNV/7kyWdpeo7UqYo="; # replace this with the correct sha256 hash
      };
    });

    # use this package for mupdf backend (faster)
    zathura = prev.zathura.overrideAttrs (oldAttrs: {
      pname = "zathura";
      version = "0.4.1";

      src = final.fetchFromGitHub {
        owner = "pwmt";
        repo = "zathura-pdf-mupdf";
        rev = "0.4.1"; # set the revision to the commit hash or tag you want
        sha256 = "sha256-JvYDTVSV9h+weSS3XOWl9B2bo3CatrsPzVNVmKpTSK8="; # replace this with the correct sha256 hash
      };
    });

    # use lf-sixel for sixel image previews in wezterm
    lf = prev.callPackage (
      {
        lib,
        stdenv,
        buildGoModule,
        fetchFromGitHub,
        installShellFiles,
      }:
        buildGoModule rec {
          pname = "lf";
          version = "31";

          src = fetchFromGitHub {
            owner = "gokcehan";
            repo = "lf";
            rev = "r${version}";
            hash = "sha256-Tuk/4R/gGtSY+4M/+OhQCbhXftZGoxZ0SeLIwYjTLA4=";
          };

          vendorHash = "sha256-PVvHrXfMN6ZSWqd5GJ08VaeKaHrFsz6FKdDoe0tk2BE=";
        }
    ) {};
  };
}
