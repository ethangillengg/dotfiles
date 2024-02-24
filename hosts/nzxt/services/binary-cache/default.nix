{
  config,
  pkgs,
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
      # TODO: temporary fix for NixOS/nix#7704
      package = pkgs.nix-serve.override {nix = pkgs.nixVersions.nix_2_12;};
      inherit port;
    };
  };
}
