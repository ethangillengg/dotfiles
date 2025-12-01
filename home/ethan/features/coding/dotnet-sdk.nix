{pkgs, ...}: let
  dotnet-combined = (with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_9_0_1xx-bin
      sdk_10_0-bin
    ]).overrideAttrs (finalAttrs: previousAttrs: {
    # This is needed to install workload in $HOME
    # https://discourse.nixos.org/t/dotnet-maui-workload/20370/2

    postBuild =
      (previousAttrs.postBuild or '''')
      + ''

        for i in $out/sdk/*
        do
          i=$(basename $i)
          mkdir -p $out/metadata/workloads/''${i/-*}
          touch $out/metadata/workloads/''${i/-*}/userlocal
        done
      '';
  });
in {
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnet-combined}";
  };
  home.packages = [
    dotnet-combined
  ];
}
