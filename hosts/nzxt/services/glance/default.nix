{port, ...}: {
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        inherit port;
      };
    };
  };
}
