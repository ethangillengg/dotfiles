{lib, ...} @ args: let
  domain = args.domain;
  user = args.user;
  group = args.group;
in {
  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
      inherit user;
      inherit group;
    };
    radarr = {
      enable = true;
      openFirewall = true;
      inherit user;
      inherit group;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    # nginx.virtualHosts."sonarr.${domain}" = {
    #   enableACME = true;
    #   forceSSL = true; # redirect http to https
    #   locations = {
    #     "/" = {
    #       proxyWebsockets = true;
    #       recommendedProxySettings = true;
    #       proxyPass = "http://localhost:8989";
    #     };
    #   };
    # };
    #
    # nginx.virtualHosts."radarr.${domain}" = {
    #   enableACME = true;
    #   forceSSL = true; # redirect http to https
    #   locations = {
    #     "/" = {
    #       proxyWebsockets = true;
    #       recommendedProxySettings = true;
    #       proxyPass = "http://localhost:7878";
    #     };
    #   };
    # };
    #
    # nginx.virtualHosts."prowlarr.${domain}" = {
    #   enableACME = true;
    #   forceSSL = true; # redirect http to https
    #   locations = {
    #     "/" = {
    #       proxyWebsockets = true;
    #       recommendedProxySettings = true;
    #       proxyPass = "http://localhost:9696";
    #     };
    #   };
    # };
  };

  users.groups.${group} = lib.mkDefault {};
  users.users.${user} = lib.mkDefault {
    description = "Media services";
    group = group;
  };
}
