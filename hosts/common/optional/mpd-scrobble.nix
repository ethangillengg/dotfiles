{config, ...}: {
  sops.secrets.listenbrainz = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };
  sops.secrets.lastfm = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };
  services.mpdscribble = {
    enable = true;
    port = 6600;
    endpoints = {
      "listenbrainz" = {
        username = "greatredswarm";
        passwordFile = config.sops.secrets.listenbrainz.path;
      };

      "last.fm" = {
        username = "greatredswarm";
        passwordFile = config.sops.secrets.lastfm.path;
      };
    };
  };
}
