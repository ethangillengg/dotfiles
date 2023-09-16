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
        speedFactor = 1;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
      {
        hostName = "localhost";
        system = "x86_64-linux";
        maxJobs = 4;
        # This is the only builder marked as aarch64, so these builds will always
        # run here (regardless of speedFactor).
        # As for x86_64, this machine's factor is much lower than the others, so
        # these builds will only be picked up if the others are offline.
        speedFactor = 1;
        supportedFeatures = ["kvm" "big-parallel" "nixos-test"];
      }
    ];
    distributedBuilds = true;
    # optional, useful when the builder has a faster internet connection than yours
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
