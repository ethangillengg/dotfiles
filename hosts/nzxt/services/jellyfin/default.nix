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
    # nginx = {
    #   virtualHosts.${domain} = {
    #     locations = {
    #       "/${url}" = {
    #         return = "301 /${url}/web/index.html";
    #       };
    #       # exact match on /media/
    #       "=/${url}/" = {
    #         return = "301 /media/web/index.html";
    #       };
    #       # match on /media/*
    #       "/${url}/" = {
    #         proxyWebsockets = true;
    #         recommendedProxySettings = true;
    #         proxyPass = "http://localhost:${toString port}";
    #         extraConfig = "rewrite ^/${url}/(.*) /$1 break;"; # proxy to jellyfin without the /media/
    #       };
    #     };
    #   };
    # };
  };

  users = {
    groups.${group} = {};
    users.${user} = {
      description = "Media services";
      group = group;
    };
  };
}
