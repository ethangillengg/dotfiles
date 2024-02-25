{
  programs. git = {
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

      p = "push";
      s = "status";
      ss = "status --short"; # Pretty "git status"
      l = "log";
      c = "commit";
      cA = "commit --amend"; # ammend with new message
      ca = "commit --amend -C HEAD"; # use the previous commit message
      d = "diff";
      a = "add";
      r = "restore . --staged";

      # copy current commit hash to clipboard and also echo it
      cp = "!git rev-parse HEAD | tr -d '\\n' | wl-copy && echo \"Copied SHA $(git rev-parse HEAD)\"";
      rp = "rev-parse HEAD";

      ch = "checkout";
      chm = "checkout main";
    };

    extraConfig = {
      init.defaultBranch = "main";
      # Pretty "git log"
      log.date = "short";
      format.pretty = "* %C(Yellow)%h %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s";
    };
  };
  home.shellAliases = {
    g = "git";
  };
}
