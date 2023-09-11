{
  services.lirc = {
    enable = true;
    configs = [];
    options = ''
      [lircd]
      nodaemon = False
      device = /dev/ttyUSB0
      driver = uirt2_raw
    '';
  };
}
