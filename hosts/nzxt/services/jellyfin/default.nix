{...} @ args: let
  domain = args.domain;
  port = args.port;
  url = args.url;

  user = args.user;
  group = args.group;
in {
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
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

  users = {
    groups.${group} = {};
    users.${user} = {
      description = "Media services";
      group = group;
    };
  };
}
