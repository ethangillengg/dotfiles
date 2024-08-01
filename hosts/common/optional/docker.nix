{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
  virtualisation.docker = {
    enable = true;
  };

  users.users.ethan.extraGroups = ["docker"];
}
