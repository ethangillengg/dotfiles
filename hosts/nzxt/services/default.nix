{
  pkgs,
  lib,
  config,
  ...
}: let
  # Base info
  email = "ethan.gill@ucalgary.ca";
  serverDomain = "mignet.duckdns.org";
  mediaUser = {
    user = "media";
    group = "media";
  };

  # Helper functions
  nginxProxy = {
    port,
    proxy,
    ...
  }: let
    proxyDomain = "${proxy.subdomain}.${serverDomain}";
  in {
    ${proxyDomain} = {
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
  };

  mediaService = {
    path,
    port ? null,
    user ? mediaUser.user,
    group ? mediaUser.group,
    extraArgs ? {},
    ...
  }:
    import path ({
        inherit user group port; # from args
        inherit pkgs lib config; # from nixos inputs
      }
      // extraArgs);

  # Service Configurations
  mediaServiceConfigs = [
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
  ];

  servarr = import ./servarr {
    domain = serverDomain;
    inherit (mediaUser) user group;
    inherit lib;
  };

  nginx = import ./nginx {
    domain = serverDomain;
    inherit email;
    inherit pkgs;
  };

  mediaServices = map mediaService mediaServiceConfigs;
  nginxProxies = map nginxProxy mediaServiceConfigs;

  # Merge all mapped proxies into a single attribute set
  # see example: https://nixos.org/manual/nix/stable/language/builtins.html#builtins-foldl'
  virtualHosts = builtins.foldl' (acc: elem: elem // acc) {} nginxProxies;
in {
  imports =
    [
      nginx
      servarr

      ./binary-cache
      ./adguard
      ./samba
    ]
    ++ mediaServices;
  # Nginx proxy subdomains
  services.nginx.virtualHosts = virtualHosts;

  users.groups.${mediaUser.group} = lib.mkDefault {};
  users.users.${mediaUser.user} = lib.mkDefault {
    description = "Media services";
    group = mediaUser.group;
  };

  # open (custom) port for ssh
  networking.firewall.allowedTCPPorts = [420 8080];
}
