{config, ...}: {
  # fix for: https://github.com/NixOS/nixpkgs/issues/155475
  systemd.services.prowlarr.environment.HOME = "/var/empty";

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  sops.secrets.prowlarr-api-key.sopsFile = ../../secrets.yaml;
  services.prometheus.exporters.exportarr-prowlarr = {
    enable = true;
    apiKeyFile = config.sops.secrets.prowlarr-api-key.path;
    url = "http://localhost:9696";
    port = 9697;
  };
}
