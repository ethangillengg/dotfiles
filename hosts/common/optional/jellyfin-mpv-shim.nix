{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jellyfin-mpv-shim
  ];
}
