{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
}
