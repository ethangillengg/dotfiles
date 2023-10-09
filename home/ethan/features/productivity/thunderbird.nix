{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    package = pkgs.betterbird;
    profiles = {
      ethan.isDefault = true;
    };
  };
}
