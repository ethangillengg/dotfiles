{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      ethan.isDefault = true;
    };
    settings = {
      "calendar.alarms.show" = true;
      "calendar.alarms.showmissed" = false;
    };
  };
}
