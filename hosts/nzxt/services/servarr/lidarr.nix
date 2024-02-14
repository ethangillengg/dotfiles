{
  user,
  group,
  ...
}: {
  services .lidarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };
}
