{
  pkgs,
  lib,
  config,
  ...
}: let
  domain = "mignet.duckdns.org";
  mediaUser = "media";
  email = "ethan.gill@ucalgary.ca";

  nginx = import ./nginx {
    inherit domain;
    inherit pkgs;
    inherit email;
  };

  mediaserver = import ./jellyfin {
    domain = "media.${domain}";
    user = mediaUser;
    group = mediaUser;
    port = 8096;
  };

  kavita = import ./kavita {
    domain = "books.${domain}";
    port = 7002;
  };

  qbittorrent = import ./qbittorrent {
    domain = "arr.${domain}";
    user = mediaUser;
    group = mediaUser;
    port = 6969;
    inherit config;
  };

  nzbget = import ./nzbget {
    domain = "nzb.${domain}";
    user = mediaUser;
    group = mediaUser;
    port = 6970;
  };

  servarr = import ./servarr {
    domain = domain;
    user = mediaUser;
    group = mediaUser;
    inherit lib;
  };
in {
  imports = [
    nginx
    mediaserver
    qbittorrent
    nzbget
    kavita
    servarr
    ./binary-cache
    ./adguard
    ./samba
  ];
  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420 8080];
}
