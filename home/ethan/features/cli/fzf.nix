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

    changeDirWidget = {
      command = "${fd} --type d --hidden";
      options = ["--preview '${tree} -C {} | head -200'" "--height 100%"];
    };

    fileWidget = {
      command = "${fd} --type f --hidden";
      options = ["--preview '${ctpv} {}'" "--height 100%"];
    };
  };
}
