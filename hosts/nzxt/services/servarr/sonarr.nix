{
  user,
  group,
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
}
