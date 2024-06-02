{
  nix = {
    settings = {
      # add this here so nzxt does not get itself added
      substituters = [
        "https://nix.mignet.duckdns.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix.mignet.duckdns.org:ofuHUoAmBPCdi27E1iHo1GoEblp3itJpog/ex9gXSAA="
      ];
      builders-use-substitutes = true;
      max-jobs = 2;
    };
    buildMachines = [
      {
        hostName = "nzxt";
        system = "x86_64-linux";
        maxJobs = 6;
        speedFactor = 3;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    distributedBuilds = true;
  };
}
