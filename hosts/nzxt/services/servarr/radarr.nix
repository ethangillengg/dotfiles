{
  user,
  group,
  ...
}: {
  services.radarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };
}
