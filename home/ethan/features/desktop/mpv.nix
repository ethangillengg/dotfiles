{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = [pkgs.mpvScripts.thumbnail];
    config = {
      osc = "no";
    };
  };
}
