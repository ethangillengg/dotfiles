{
  user,
  group,
  config,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
    "dotnet-core-combined"
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-7.0.410"
  ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    inherit user group;
  };

  sops.secrets.sonarr-api-key.sopsFile = ../../secrets.yaml;
  services.prometheus.exporters.exportarr-sonarr = {
    enable = true;
    apiKeyFile = config.sops.secrets.sonarr-api-key.path;
    url = "http://localhost:8989";
    port = 8990;
  };
}
