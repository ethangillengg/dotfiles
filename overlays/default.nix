{
  outputs,
  inputs,
}: {
  # Adds my custom packages
  additions = final: prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # lf = prev.lf.overrideAttrs (oldAttrs: {
    #   pname = "lf";
    #   # version = "custom"; # set the version to something that makes sense for you
    #   src = final.fetchFromGitHub {
    #     owner = "horriblename";
    #     repo = "lf";
    #     rev = "master"; # set the revision to the commit hash or tag you want
    #     sha256 = "sha256-CoWF3virzel8TbW79xc6xXxh6K6r9mCeoaAUYcE7VHc="; # replace this with the correct sha256 hash
    #   };
    # });

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
