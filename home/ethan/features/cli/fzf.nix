{pkgs, ...}: let
  # Dependencies
  fd = "${pkgs.fd}/bin/fd";
  tree = "${pkgs.tree}/bin/tree";
  ctpv = "${pkgs.ctpv}/bin/ctpv";
in {
  programs.fzf = {
    enable = true;
    defaultCommand = "${fd} . --hidden --exclude \".git\"";

    defaultOptions = [
      "--border"
      "--reverse"
      "--cycle"
    ];

    changeDirWidgetCommand = "${fd} --type d --hidden";
    changeDirWidgetOptions = ["--preview '${tree} -C {} | head -200'" "--height 100%"];

    fileWidgetCommand = "${fd} --type f --hidden";
    fileWidgetOptions = ["--preview '${ctpv} {}'" "--height 100%"];
  };
}
