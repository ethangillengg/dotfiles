{
  port,
  domain,
  config,
  ...
}: {
  # grafana configuration
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = port;
        domain = domain;
        serve_from_sub_path = true;
      };
    };
  };

  # prometheus configuration
  services.prometheus = {
    enable = true;
    port = 9001;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd"];
        port = 9002;
      };
    };
    scrapeConfigs = [
      {
        job_name = "nzxt";
        static_configs = [
          {
            targets = [
              "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
              "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-radarr.port}"
              "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-sonarr.port}"
              "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-prowlarr.port}"
            ];
          }
        ];
      }
    ];
  };
}
