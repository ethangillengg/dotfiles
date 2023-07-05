{...} @ args: let
  domain = args.domain;
  port = args.port;

  user = args.user;
  group = args.group;
in {
  services.qbittorrent-nox = {
    enable = true;
    inherit user;
    inherit group;
    inherit port;
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

  services.wgnord = {
    enable = true;
    country = "canada";
    template = ''
      [Interface]
      PrivateKey = PRIVKEY
      Address = 10.5.0.2/32
      MTU = 1350
      DNS = 103.86.96.100 103.86.99.100
      TABLE = 6969

      [Peer]
      PublicKey = SERVER_PUBKEY
      AllowedIPs = 0.0.0.0/0, ::/0
      Endpoint = SERVER_IP:51820
      PersistentKeepalive = 25
    '';
  };
}
