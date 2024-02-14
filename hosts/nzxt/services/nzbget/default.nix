{
  user,
  group,
  ...
}: {
  services.nzbget = {
    enable = true;
    inherit user;
    inherit group;
  };
}
