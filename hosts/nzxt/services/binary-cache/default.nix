{
  config,
  port,
  ...
}: {
  sops.secrets.cache-sig-key = {
    sopsFile = ../../secrets.yaml;
  };
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile = config.sops.secrets.cache-sig-key.path;
      inherit port;
    };
  };
}
