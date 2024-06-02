{
  config,
  port,
  ...
}: {
  sops.secrets.binary-cache-priv-key = {
    sopsFile = ../../secrets.yaml;
  };
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile = config.sops.secrets.binary-cache-priv-key.path;
      inherit port;
    };
  };
}
