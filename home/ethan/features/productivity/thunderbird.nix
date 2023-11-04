{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      ethan.isDefault = true;
    };
  };
}
