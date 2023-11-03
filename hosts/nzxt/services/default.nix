{
  pkgs,
  lib,
  config,
  ...
}: let
  domain = "gillwire.duckdns.org";
  mediaUser = "media";
  email = "ethan.gill@ucalgary.ca";

  nginx = import ./nginx {
    inherit pkgs;
    inherit domain;
    inherit email;
  };

  mediaserver = import ./jellyfin {
    inherit domain;
    user = mediaUser;
    group = mediaUser;
    port = 8096;
  };

  komga = import ./komga {
    domain = "manga.${domain}";
    user = mediaUser;
    group = mediaUser;
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

  samba = import ./samba {
    inherit pkgs;
  };
in {
  imports = [
    nginx
    mediaserver
    qbittorrent
    nzbget
    komga
    samba
    servarr
    ./binary-cache
  ];
  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420 8080];
}
