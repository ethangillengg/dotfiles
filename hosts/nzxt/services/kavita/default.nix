{
  lib,
  pkgs,
  ...
} @ args: let
  port = args.port;
  domain = args.domain;
  user = args.user;
  group = args.group;
  # Ensure that the user and group 'kavita' exists
in {
  services = {
    kavita = {
      enable = true;
      tokenKeyFile = "/var/lib/kavita/token";
      inherit port;
      # inherit user;
    };
  };
  users.groups.${group} = lib.mkDefault {};
  users.users.${user} = lib.mkDefault {
    description = "Media services";
    group = group;
  };

  # # Define the systemd service
  # systemd.services.kavita = {
  #   description = "Kavita Server";
  #   after = ["network.target"];
  #   wantedBy = ["multi-user.target"];
  #
  #   serviceConfig = {
  #     Type = "simple";
  #     User = user;
  #     Group = group;
  #     WorkingDirectory = "/opt/Kavita";
  #     ExecStart = "${pkgs.kavita}/bin/kavita"; # Assuming that the package is called 'kavita'. You need to adjust this according to the actual package name.
  #     TimeoutStopSec = 20;
  #     KillMode = "process";
  #     Restart = "on-failure";
  #   };
  # };

  services.nginx.virtualHosts.${domain} = {
    enableACME = true;
    forceSSL = true; # redirect http to https
    locations = {
      "/" = {
        proxyWebsockets = true;
        recommendedProxySettings = true;
        proxyPass = "http://localhost:${toString port}";
      };
    };
  };
}
