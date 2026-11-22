{
  outputs,
  inputs,
}: {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.stdenv.hostPlatform.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.stdenv.hostPlatform.system}'
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs
      (
        _: flake: let
          system = final.stdenv.hostPlatform.system;
          legacyPackages = (flake.legacyPackages or {}).${system} or {};
          packages = (flake.packages or {}).${system} or {};
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
    # see: (https://github.com/NixOS/nixpkgs/issues/361550, https://github.com/NixOS/nixpkgs/issues/363965)

    openldap = prev.openldap.overrideAttrs (_: {
      doCheck = false;
    });
    # open-webui = prev.open-webui.overrideAttrs (oldAttrs: rec {
    #   pname = "open-webui";
    #   version = "0.4.7";
    #
    #   src = final.fetchFromGitHub {
    #     owner = "open-webui";
    #     repo = "open-webui";
    #     rev = "v${version}";
    #     hash = "sha256-LQFedDcECmS142tGH9+/7ic+wKTeMuysK2fjGmvYPYQ=";
    #   };
    # });
  };
}
