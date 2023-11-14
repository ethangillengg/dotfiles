{...} @ args: let
  domain = args.domain;
  port = args.port;

  user = args.user;
  group = args.group;
in {
  services.nzbget = {
    enable = true;
    inherit user;
    inherit group;
  };

  # services.nginx.virtualHosts.${domain} = {
  #   enableACME = true;
  #   forceSSL = true; # redirect http to https
  #   locations = {
  #     "/" = {
  #       proxyWebsockets = true;
  #       recommendedProxySettings = true;
  #       proxyPass = "http://localhost:${toString port}";
  #     };
  #   };
  # };
}
