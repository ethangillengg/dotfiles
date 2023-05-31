{pkgs, ...} @ args: let
  domain = args.domain;
  port = args.port;
  # user = args.user;
  # group = args.group;
in {
  services = {
    nextcloud = {
      enable = true;
      hostName = domain;
      config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
      https = true;

      package = pkgs.nextcloud26;
      # extraApps = with pkgs.nextcloud25Packages.apps; {
      #   inherit externalstorage;
      # };
      extraAppsEnable = true;
    };

    nginx.virtualHosts.${domain} = {
      enableACME = true;
      forceSSL = true; # redirect http to https
      # listen = [{ addr = "127.0.0.1"; inherit port; }];
      # locations = {
      #   "/" = {
      #     proxyWebsockets = true;
      #     recommendedProxySettings = true;
      #     proxyPass = "http://localhost:${toString port}";
      #   };
      # };
    };

    nginx.virtualHosts."files.gillwire.duckdns.org" = {
      enableACME = true;
      forceSSL = true; # redirect http to https

      locations."/" = {
        proxyWebsockets = true;
        recommendedProxySettings = true;
        proxyPass = "http://localhost:${toString 8080}";
      };
    };
  };

  users.users.nextcloud.extraGroups = ["mediaserver"];
}
