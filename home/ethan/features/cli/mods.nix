{pkgs, ...}: {
  home.packages = with pkgs; [
    mods
  ];
}
