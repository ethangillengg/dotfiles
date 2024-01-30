{pkgs, ...}: let
  wlsunset = "${pkgs.wlsunset}/bin/wlsunset";
in {
  home.packages = [
    pkgs.wlsunset
  ];
  wayland.windowManager.sway.config = {
    startup = [
      {
        # 6:30AM - 8:00PM
        command = "${wlsunset} -t 3200 -S 06:30 -s 18:00";
      }
    ];
  };
}
