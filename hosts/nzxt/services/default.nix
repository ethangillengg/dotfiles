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

  jellyfin = import ./jellyfin {
    domain = "media.${domain}";
    user = mediaUser;
    group = mediaUser;
    port = 8096;
  };

  navidrome = import ./navidrome {
    domain = "media.${domain}";
    user = mediaUser;
    group = mediaUser;
    port = 4533;
  };

  kavita = import ./kavita {
    user = mediaUser;
    group = mediaUser;
    domain = "books.${domain}";
    port = 7002;
    inherit pkgs;
    inherit lib;
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
    jellyfin
    qbittorrent
    nzbget
    kavita
    servarr
    navidrome
    ./binary-cache
    ./adguard
    ./samba
  ];
  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420 8080];
}
