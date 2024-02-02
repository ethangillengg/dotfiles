{config, ...}: {
  sops.secrets.listenbrainz = {
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
    };
  };
}
