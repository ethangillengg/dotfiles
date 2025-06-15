{
  port,
  config,
  ...
}: {
  sops.secrets.mealie-env.sopsFile = ../../secrets.yaml;

  services = {
    mealie = {
      inherit port;
      credentialsFile = config.sops.secrets.mealie-env.path;
    };
  };
}
