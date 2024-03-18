{
  config,
  pkgs,
  ...
}: {
  # Add Docker and docker-compose to the system packages
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  # Enable the Docker daemon
  virtualisation.docker.enable = true;

  # Define custom systemd service
  systemd.services.heartlens = {
    description = "HeartLens Docker Service";
    after = ["network-online.target" "docker.service"];
    wants = ["docker.service"];
    wantedBy = ["multi-user.target"];
    script = ''
      exec ${pkgs.docker-compose}/bin/docker-compose --profile prod up
    '';
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/home/ethan/Downloads/HeartLens";
      Restart = "always";
      RestartSec = "1min";
      User = "ethan";
      Environment = "START_FROM_SCRATCH=true";
    };
  };
}
