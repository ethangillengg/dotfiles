{
  user,
  group,
  config,
  ...
}: {
  services.radarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };

  sops.secrets.radarr-api-key.sopsFile = ../../secrets.yaml;
  services.prometheus.exporters.exportarr-radarr = {
    enable = true;
    apiKeyFile = config.sops.secrets.radarr-api-key.path;
    url = "http://localhost:7878";
    port = 7879;
  };
}
