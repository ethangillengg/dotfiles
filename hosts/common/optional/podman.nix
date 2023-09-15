{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
  ];
  virtualisation.podman = {
    enable = true;
  };
}
