{port, ...}: {
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        inherit port;
      };

      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "full";
              widgets = [
                {type = "search";}
                {
                  type = "videos";
                  channels = [
                    "UCUyeluBRhGPCW4rPe_UvBZQ"
                    "UCXuqSBlHAE6Xw-yeJA0Tunw"
                    "UC7dF9qfBMXrSlaaFFDvV_Yg"
                  ];
                }
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "3h";
                  feeds = [
                    {url = "https://ciechanow.ski/atom.xml";}
                    {
                      url = "https://xeiaso.net/blog.rss";
                      title = "Xe Iaso";
                    }
                    {url = "https://samwho.dev/rss.xml";}
                    {url = "https://awesomekling.github.io/feed.xml";}
                    {
                      url = "https://fasterthanli.me/index.xml";
                      title = "fasterthanlime";
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "Calgary, Canada";
                }
                {
                  type = "monitor";
                  cache = "5m";
                  sites = [
                    {
                      title = "Jellyfin";
                      url = "https://media.mignet.duckdns.org";
                    }
                    {
                      title = "Kavita";
                      url = "https://mignet.duckdns.org";
                    }
                    {
                      title = "Nix Cache";
                      url = "https://nix.mignet.duckdns.org/nix-cache-info";
                    }
                  ];
                }
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "VFV.TO";
                      name = "Vanguard S&P 500 Index";
                    }
                    {
                      symbol = "SPY";
                      name = "S&P 500";
                    }
                    {
                      symbol = "NVDA";
                      name = "NVIDIA";
                    }
                    {
                      symbol = "AAPL";
                      name = "Apple";
                    }
                    {
                      symbol = "MSFT";
                      name = "Microsoft";
                    }
                    {
                      symbol = "GOOGL";
                      name = "Google";
                    }
                    {
                      symbol = "AMD";
                      name = "AMD";
                    }
                    {
                      symbol = "RDDT";
                      name = "Reddit";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
