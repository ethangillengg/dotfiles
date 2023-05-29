{ ... } @args:

let
  domain = args.domain;

  port = args.port;
in
{

  services.vaultwarden = {
    enable = true;
    config = {
      ADMIN_TOKEN = "LU9bFopb4B^H5SFm!X!g*zQj";
      INVITATIONS_ALLOWED = true;
      SIGNUPS_ALLOWED = false;
      DOMAIN = "https://${domain}";
      ROCKET_PORT = port;
    };
  };

  services.nginx.virtualHosts.${domain} = {
    enableACME = true;
    forceSSL = true; # redirect http to https
    locations = {
      "/" = {
        proxyPass = "http://localhost:${toString port}";
      };
    };
  };

}

