{
  pkgs,
  lib,
  ...
} @ inputs: let
  # Base info
  email = "ethan.gill@ucalgary.ca";
  serverDomain = "mignet.duckdns.org";
  mediaUser = {
    user = "media";
    group = "media";
  };

  helpers = import ./helpers.nix (
    {inherit email serverDomain mediaUser;}
    # pass all the NixOS inputs (pkgs, lib, config, etc.)
    // inputs
  );
  inherit (helpers) mediaService nginxProxy; # expose helpers to this scope

  # Service Configurations
  mediaServiceConfigs = [
    {
      path = ./monitoring/grafana.nix;
      port = 9876;
      proxy = {
        enable = true;
        subdomain = "grafana";
      };
    }
    {
      path = ./jellyfin;
      port = 8096;
      proxy = {
        enable = true;
        subdomain = "media";
      };
    }
    {
      path = ./navidrome;
      port = 4533;
      proxy = {
        enable = true;
        subdomain = "music";
      };
    }
    {
      path = ./kavita;
      port = 7002;
      proxy = {
        enable = true;
        subdomain = "books";
      };
    }
    {
      path = ./qbittorrent;
      port = 6969;
      proxy = {
        enable = true;
        subdomain = "arr";
      };
    }
    {
      path = ./nzbget;
      port = 6970;
      proxy = {
        enable = true;
        subdomain = "nzb";
      };
    }

    {
      path = ./binary-cache;
      port = 9998;
      proxy = {
        enable = true;
        subdomain = "nix";
      };
    }

    # Servarr stack
    {path = ./servarr/sonarr.nix;}
    {path = ./servarr/radarr.nix;}
    {path = ./servarr/prowlarr.nix;}
    {path = ./servarr/bazarr.nix;}
    {path = ./servarr/lidarr.nix;}
  ];

  nginx = import ./nginx {
    domain = serverDomain;
    inherit email;
    inherit pkgs;
  };

  # only proxy if "proxy.enable = true"
  servicesToProxy = builtins.filter ({proxy ? {enable = false;}, ...}:
    proxy.enable)
  mediaServiceConfigs;
  nginxProxies = map nginxProxy servicesToProxy;

  # Merge all mapped proxies into a single attribute set
  # see example: https://nixos.org/manual/nix/stable/language/builtins.html#builtins-foldl'
  virtualHosts = builtins.foldl' (acc: elem: elem // acc) {} nginxProxies;
in {
  imports =
    [
      nginx
      ./samba
      ./heartlens.nix
    ]
    ++ map mediaService mediaServiceConfigs;

  # Nginx proxy subdomains
  services.nginx.virtualHosts = virtualHosts;

  users.groups.${mediaUser.group} = lib.mkDefault {};
  users.users.${mediaUser.user} = lib.mkDefault {
    description = "Media services";
    group = mediaUser.group;
    isNormalUser = lib.mkForce true;
  };

  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420 8080];
}
