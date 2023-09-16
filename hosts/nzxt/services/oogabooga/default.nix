{pkgs, ...} @ args: let
  domain = args.domain;
  port = args.port;
in {
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
  users.users."ethan".extraGroups = ["docker"];

  # services.nginx.virtualHosts.${domain} = {
  #   enableACME = true;
  #   forceSSL = true; # redirect http to https
  #
  #   locations = {
  #     "/" = {
  #       proxyWebsockets = true;
  #       recommendedProxySettings = true;
  #       proxyPass = "http://localhost:${toString port}";
  #     };
  #   };
  # };

  environment.systemPackages = with pkgs; [
    gnumake
    wget
    # python3
    # python3Packages.virtualenv
    # python3Packages.pip
    # gcc11
    # libgccjit
    # conda
    # micromamba
    # ninja
    #
    # libxml2
    # cudaPackages.cudatoolkit

    # blas
    cargo
  ];
}
