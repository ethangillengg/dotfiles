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
    proxy ? {},
    ...
  }:
    import path (
      {
        inherit user group port; # from args

        domain =
          if proxy.subdomain != null
          then "${proxy.subdomain}.${serverDomain}"
          else null;
      }
      // extraArgs
      // inputs # pass all the NixOS inputs forward
    );
}
