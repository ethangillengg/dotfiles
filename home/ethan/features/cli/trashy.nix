{pkgs, ...}: let
  trashy = "${pkgs.trashy}/bin/trash";
in {
  home.packages = [
    pkgs.trashy
  ];
  home.shellAliases = {
    "tp" = "${trashy} put";
  };
}
