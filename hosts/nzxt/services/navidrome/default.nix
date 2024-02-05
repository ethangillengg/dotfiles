{lib, ...} @ args: let
  port = args.port;
  domain = args.domain;
  user = args.user;
  group = args.group;
  # Ensure that the user and group 'kavita' exists
in {
  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      Port = port;
      MusicFolder = "/mnt/mediaserver/data/media/music";
      PlaylistsPath = "."; # only in root music dir
      CovertArtPriority = "*.jpg, *.JPG, *.png, *.PNG, embedded";
      AutoImportPlaylists = true;
      EnableSharing = true;
      ScanSchedule = "@every 1h"; # scan for music/playlists every hour
      DefaultTheme = "Gruvbox Dark";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce user;
    Group = lib.mkForce group;
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
}
