{
  imports = [../tailscale.nix];
  services.tailscale = {
    useRoutingFeatures = "both";
  };
}
