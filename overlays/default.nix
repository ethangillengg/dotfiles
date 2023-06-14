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
  };
}
