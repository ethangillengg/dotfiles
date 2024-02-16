{
  user,
  group,
  config,
  ...
}: {
  services.bazarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };

  sops.secrets.bazarr-api-key.sopsFile = ../../secrets.yaml;
  services.prometheus.exporters.exportarr-bazarr = {
    enable = true;
    apiKeyFile = config.sops.secrets.bazarr-api-key.path;
    url = "http://localhost:7878";
    port = 6768;
  };
}
