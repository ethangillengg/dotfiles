{ config, pkgs, outputs, ... }:

let
  qbittorrent-port = 6969;
in
{
  services.qbittorrent-nox = {
    enable = true;
    user = "media";
    group = "media";
    port = qbittorrent-port;
  };


  services.wgnord = {
    enable = true;
    token = "MY_TOKEN";
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

  networking.firewall.allowedTCPPorts = [ qbittorrent-port ];
}