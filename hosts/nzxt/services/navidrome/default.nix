{...} @ args: let
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
      CovertArtPriority = "*.jpg, *.JPG, *.png, *.PNG, embedded";
      AutoImportPlaylists = true;
      EnableSharing = true;
    };
  };
}
