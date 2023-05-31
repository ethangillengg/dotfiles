{pkgs, ...} @ args: let
  domain = args.domain;
  url = args.url;
  email = args.email;

  # Get the path to index.html
  indexPath = builtins.path {
    name = "index.html";
    path = ./index.html;
  };

  # Define directory in the nix store with the index.html file
  indexDir = pkgs.runCommandLocal "nginx-index-directory" {} ''
    mkdir -p $out
    cp ${indexPath} $out/index.html
  '';
in {
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      virtualHosts.${domain} = {
        enableACME = true;
        forceSSL = true; # redirect http to https
        locations = {
          "/" = {
            root = indexDir;
            index = "index.html";
            tryFiles = "$uri $uri/ =404";
          };
        };
      };
      virtualHosts."dev.${domain}" = {
        enableACME = true;
        forceSSL = true; # redirect http to https
        locations = {
          "/" = {
            proxyPass = "http://localhost:3000";
          };
        };
      };
    };
  };

  # Http + Https
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults = {inherit email;};
  };
}
