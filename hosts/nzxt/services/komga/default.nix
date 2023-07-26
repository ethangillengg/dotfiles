{...} @ args: let
  domain = args.domain;
  port = args.port;

  user = args.user;
  group = args.group;
in {
  services = {
    komga = {
      enable = true;
      openFirewall = true;
      inherit port;
      inherit user;
      inherit group;
    };

    nginx.virtualHosts.${domain} = {
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
  };

  # users = {
  #   groups.${group} = {};
  #   users.${user} = {
  #     description = "Media services";
  #     group = group;
  #   };
  # };
}
