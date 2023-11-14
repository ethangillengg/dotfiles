{
  programs.git = {
    enable = true;
    userName = "Ethan Gill";
    userEmail = "ethan.gill@ucalgary.ca";
    signing = {
      signByDefault = true;
      key = "4AF98CB0736E4B95DEE74A28BC3D2A808673D24F";
    };

    aliases = {
      graph = "log --decorate --oneline --graph";
      undo = "reset --soft HEAD~1";
      tracked = "for-each-ref --format='%(refname:short) <- %(upstream:short)' refs/heads";
    };

    extraConfig = {
      init.defaultBranch = "main";
      # Pretty "git log"
      log.date = "short";
      format.pretty = "* %C(Yellow)%h %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s";
    };
  };
  home.shellAliases = {
    gp = "git push";
    gs = "git status";
    gss = "git status --short"; # Pretty "git status"
    gl = "git log";
    gc = "git commit";
    gca = "git commit --amend -C HEAD"; # use the previous commit message
    gd = "git diff";
    ga = "git add";
  };
}
