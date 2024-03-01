{pkgs, ...}: {
  imports = [
    ./fcitx5
  ];
  home.packages = with pkgs; [
    qolibri # japanese dictionary
  ];
}
