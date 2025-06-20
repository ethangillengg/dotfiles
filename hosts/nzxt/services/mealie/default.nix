{
  port,
  config,
  ...
}: {
  sops.secrets.mealie-env.sopsFile = ../../secrets.yaml;

  services = {
    mealie = {
      enable = true;
      inherit port;
      credentialsFile = config.sops.secrets.mealie-env.path;
    };
  };
}
