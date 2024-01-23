{
  programs.thunderbird = {
    enable = true;
    profiles = {
      ethan.isDefault = true;
    };
    settings = let
      date_format = "yyyy-MM-dd";
      time_format = "II:mm";
    in {
      "calendar.alarms.show" = true;
      "calendar.alarms.showmissed" = false;
      "mail.purge.ask" = false;
      "mail.startup.enabledMailCheckOnce" = true;
      "mailnews.start_page.enabled" = false;
      "network.cookie.cookieBehavior" = 3;
      "places.history.enabled" = false;
      "privacy.trackingprotection.enabled" = true;
      "privacy.donottrackheader.enabled" = true;
      # "intl.date_time.pattern_override.date_short" = date_format;
      # "intl.date_time.pattern_override.date_medium" = date_format;
      # "intl.date_time.pattern_override.date_long" = date_format;
      # "intl.date_time.pattern_override.date_full" = date_format;
      # "intl.date_time.pattern_override.time_short" = time_format;
      # "intl.date_time.pattern_override.time_medium" = time_format;
      # "intl.date_time.pattern_override.time_long" = time_format;
      # "intl.date_time.pattern_override.time_full" = time_format;
      # "intl.date_time.pattern_override.connector_short" = " ";
    };
  };
}
