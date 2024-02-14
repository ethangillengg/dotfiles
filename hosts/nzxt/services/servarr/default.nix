{
  user,
  group,
  ...
}: {
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

    lidarr = {
      enable = true;
      openFirewall = true;
      inherit user group;
    };
  };
}
