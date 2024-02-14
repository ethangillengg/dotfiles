{
  user,
  group,
  ...
}: {
  services.sonarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };
}
