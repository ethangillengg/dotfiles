{ config, pkgs, ... }:
let
  mediaServerUser = "media";
  mediaServerGroup = "media";
  jellyfin = {
    port = 8096;
    url = "media";
  };
  qBittorrent = {
    port = 6969;
    url = "arr";
  };

  defaultMediaService = {
    enable = true;
    openFirewall = true;
    user = mediaServerUser;
    group = mediaServerGroup;
  };

  # Get the path to index.html
  jellyfinIndexPath = builtins.path {
    name = "index.html";
    path = ./index.html;
  };

  # Define directory in the nix store with the index.html file
  jellyfinIndexDir = pkgs.runCommandLocal "jellyfin-index-directory" { } ''
    mkdir -p $out
    cp ${jellyfinIndexPath} $out/index.html
  '';
in
{


  services = {
    jellyfin = defaultMediaService;

    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;

      virtualHosts."gillwire.duckdns.org" = {
        enableACME = true;
        forceSSL = true; # redirect http to https
        locations = {
          "/" = {
            root = jellyfinIndexDir;
            index = "index.html";
            tryFiles = "$uri $uri/ =404";
          };

          "/${jellyfin.url}" = {
            return = "301 /${jellyfin.url}/web/index.html";
          };
          # exact match on /media/
          "=/${jellyfin.url}/" = {
            return = "301 /media/web/index.html";
          };
          # match on /media/*
          "/${jellyfin.url}/" = {
            proxyWebsockets = true;
            recommendedProxySettings = true;
            proxyPass = "http://localhost:${toString jellyfin.port}";
            extraConfig = "rewrite ^/${jellyfin.url}/(.*) /$1 break;"; # proxy to jellyfin without the /media/ 
          };

          "/${qBittorrent.url}/" = {
            proxyWebsockets = true;
            recommendedProxySettings = true;
            proxyPass = "http://localhost:${toString qBittorrent.port}";
            extraConfig = "rewrite ^/${qBittorrent.url}/(.*) /$1 break;";
          };
        };
      };
    };

  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80
    420 # port for ssh
    443
  ];


  users = {
    groups.${mediaServerGroup} = { };

    users.${mediaServerUser} = {
      isSystemUser = true;
      description = "Media services";
      group = mediaServerGroup;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = " greatredswarm@gmail.com";
  };
}


