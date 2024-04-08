{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    nvidia-container-toolkit
    nvidia-docker
  ];
  virtualisation.docker = {
    enable = true;
  };
}
