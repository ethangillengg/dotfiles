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
    port ? -1,
    proxy ? {},
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
      ./binary-cache
      ./adguard
      ./samba
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
