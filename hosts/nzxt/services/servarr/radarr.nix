{
  user,
  group,
  config,
  ...
}: {
  services.radarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };
}
