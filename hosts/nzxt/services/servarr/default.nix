{lib, ...} @ args: let
  domain = args.domain;
  user = args.user;
  group = args.group;
in {
  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
      inherit user group;
    };
    radarr = {
      enable = true;
      openFirewall = true;
      inherit user group;
    };

    bazarr = {
      enable = true;
      openFirewall = true;
      inherit user group;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };

  users.groups.${group} = lib.mkDefault {};
  users.users.${user} = lib.mkDefault {
    description = "Media services";
    group = group;
  };
}
