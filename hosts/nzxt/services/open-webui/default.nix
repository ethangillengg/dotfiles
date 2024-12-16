{
  port,
  config,
  ...
}: {
  sops.secrets.open-webui-env.sopsFile = ../../secrets.yaml;
  services = {
    open-webui = {
      enable = true;
      openFirewall = true;
      inherit port;
      environmentFile = config.sops.secrets.open-webui-env.path;
    };
  };
}
