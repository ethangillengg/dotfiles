{...} @ args: let
  port = args.port;
  domain = args.domain;
  user = args.user;
  group = args.group;
  # Ensure that the user and group 'kavita' exists
in {
  services.gonic = {
    enable = true;
    settings = {
      music-path = ["/mnt/mediaserver/data/media/music"];
      podcast-path = "/mnt/mediaserver/data/media/podcasts";
      playlists-path = "/mnt/mediaserver/data/media/music/.playlists/";
    };
  };
}
