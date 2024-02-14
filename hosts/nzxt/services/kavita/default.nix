{
  lib,
  pkgs,
  ...
} @ args: let
  port = args.port;
  domain = args.domain;
  user = args.user;
  group = args.group;
  # Ensure that the user and group 'kavita' exists
in {
  services = {
    kavita = {
      enable = true;
      tokenKeyFile = "/var/lib/kavita/token";
      inherit port;
      # inherit user;
    };
  };
  users.groups.${group} = lib.mkDefault {};
  users.users.${user} = lib.mkDefault {
    description = "Media services";
    group = group;
  };
}
