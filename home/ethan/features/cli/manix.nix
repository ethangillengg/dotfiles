{pkgs, ...}: let
  fzf = "${pkgs.fzf}/bin/fzf";
in {
  home.packages = with pkgs; [
    manix
  ];
  home.shellAliases = {
    "ns" = ''manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | ${fzf} --preview="manix '{}'" | xargs manix'';
  };
}
