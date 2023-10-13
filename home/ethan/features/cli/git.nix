{pkgs, ...}: let
  git-interactive = "${pkgs.git-interactive}/bin/git-interactive";
in {
  programs.git = {
    enable = true;
    userName = "Ethan Gill";
    userEmail = "ethan.gill@ucalgary.ca";
    signing = {
      signByDefault = true;
      key = "4AF98CB0736E4B95DEE74A28BC3D2A808673D24F";
    };
    delta = {
      enable = true;
    };

    aliases = {
      graph = "log --decorate --oneline --graph";
      undo = "reset --soft HEAD~1";
    };

    extraConfig = {
      init.defaultBranch = "main";
      # Pretty "git log"
      log.date = "short";
      format.pretty = "* %C(Yellow)%h %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %G? %C(Cyan)%an: %C(reset)%s";
    };
  };
  home.shellAliases = {
    gp = "git push";
    gs = "git status --short"; # Pretty "git status"
    gl = "git log";
    gc = "git commit";
    gd = "git diff";
    ga = git-interactive;
  };
}
