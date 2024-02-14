{
  serverDomain,
  mediaUser,
  ...
  # All the NixOS inputs (lib, pkgs, config, etc.)
} @ inputs
: {
  # Helper functions
  nginxProxy = {
    port ? -1,
    proxy ? {},
    ...
  }: let
    proxyDomain = "${proxy.subdomain}.${serverDomain}";
  in {
    ${proxyDomain} = {
      enableACME = true;
      forceSSL = true; # redirect http to https
      locations = {
        "/" = {
          proxyWebsockets = true;
          recommendedProxySettings = true;
          proxyPass = "http://localhost:${toString port}";
        };
      };
    };
  };

  mediaService = {
    path,
    port ? null,
    user ? mediaUser.user,
    group ? mediaUser.group,
    extraArgs ? {},
    ...
  }:
    import path (
      {
        inherit user group port; # from args
      }
      // extraArgs
      // inputs # pass all the NixOS inputs forward
    );
}
