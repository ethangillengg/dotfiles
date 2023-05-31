{
  config,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
  };
  # ...and the rest of your NixOS configuration
}
