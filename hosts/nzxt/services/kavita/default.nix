{
  lib,
  port,
  user,
  group,
  ...
}: {
  services = {
    kavita = {
      enable = true;
      tokenKeyFile = "/var/lib/kavita/token";
      settings.port = port;
      # TODO: use media server user
      # inherit user;
    };
  };
  users.groups.${group} = lib.mkDefault {};
  users.users.${user} = lib.mkDefault {
    description = "Media services";
    group = group;
  };
}
