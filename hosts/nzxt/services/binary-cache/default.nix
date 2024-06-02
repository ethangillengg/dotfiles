{
  lib,
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

  # hacky fix for issue: https://github.com/NixOS/nixpkgs/issues/154260
  users.groups.nix-serve = lib.mkDefault {};
  users.users.nix-serve = lib.mkDefault {
    description = "Nix binary cache";
    group = "nix-serve";
    isSystemUser = true;
  };
}
