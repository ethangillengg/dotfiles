{
  user,
  group,
  ...
}: {
  services.bazarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };
}
