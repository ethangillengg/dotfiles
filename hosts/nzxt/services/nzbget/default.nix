{...} @ args: let
  domain = args.domain;
  port = args.port;

  user = args.user;
  group = args.group;
in {
  services.nzbget = {
    enable = true;
    inherit user;
    inherit group;
  };
}
