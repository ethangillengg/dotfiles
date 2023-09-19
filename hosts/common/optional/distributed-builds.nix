{
  config,
  pkgs,
  ...
}: {
  nix = {
    buildMachines = [
      {
        hostName = "nzxt";
        system = "x86_64-linux";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.,
        # systems = ["x86_64-linux" "aarch64-linux"];
        maxJobs = 8;
        speedFactor = 2;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    distributedBuilds = true;
    # optional, useful when the builder has a faster internet connection than yours
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
