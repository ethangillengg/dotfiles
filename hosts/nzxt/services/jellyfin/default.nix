{
  user,
  group,
  ...
}: {
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      inherit user;
      inherit group;
    };
  };

  users = {
    groups.${group} = {};
    users.${user} = {
      description = "Media services";
      group = group;
    };
  };
}
