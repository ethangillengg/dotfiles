{
  user,
  group,
  config,
  ...
}: {
  services.sonarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };

  sops.secrets.sonarr-api-key.sopsFile = ../../secrets.yaml;
  services.prometheus.exporters.exportarr-sonarr = {
    enable = true;
    apiKeyFile = config.sops.secrets.sonarr-api-key.path;
    url = "http://localhost:8989";
    port = 8990;
  };
}
