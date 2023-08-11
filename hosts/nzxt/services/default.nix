{
  pkgs,
  lib,
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
    domain = "media.${domain}";
    # inherit domain;
    # url = "media";
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
    # inherit domain;
    # url = "arr";
    user = mediaUser;
    group = mediaUser;
    port = 6969;
  };

  oogabooga = import ./oogabooga {
    domain = "ai.${domain}";
    port = 7000;
    inherit pkgs;
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
    komga
    samba
    oogabooga
    servarr
  ];
  # ] ++ (builtins.attrValues outputs.nixosModules);

  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420];
}
