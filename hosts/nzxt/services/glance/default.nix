{port, ...}: {
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      inherit port;
    };
  };
}
