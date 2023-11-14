{...} @ args: let
  port = args.port;
  domain = args.domain;
in {
  services = {
    kavita = {
      enable = true;
      tokenKeyFile = "/var/lib/kavita/token";
      inherit port;
    };
  };

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
