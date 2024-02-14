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
}
