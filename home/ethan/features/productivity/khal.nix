{
  pkgs,
  config,
  ...
}: {
  programs.khal = {
    enable = true;
  };

  accounts.calendar = {
    basePath = "${config.home.homeDirectory}/Calendars";
  };
  # xdg.configFile."khal/config".text = ''
  #   [calendars]
  #
  #   [[calendars]]
  #   path = ~/Calendars/*
  #   type = discover
  #
  #   [locale]
  #   timeformat = %H:%M
  #   dateformat = %d/%m/%Y
  # '';
}
