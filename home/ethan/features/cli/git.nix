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
      sw = "switch";
      swm = "switch main";

      ch = "checkout";
      chm = "checkout main";
    };

    extraConfig = {
      init.defaultBranch = "main";
      push = {autoSetupRemote = true;};
      # Pretty "git log"
      log.date = "short";
      format.pretty = "* %C(Yellow)%h %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s";
    };
  };
  home.shellAliases = {
    g = "git";
    gp = "git push";
    gs = "git status";
    gss = "git status --short";
    gl = "git log";
    gc = "git commit";
    gcm = "git commit -m";
    gcA = "git commit --amend"; # ammend with new message
    gca = "git commit --amend -C HEAD"; # use the previous commit message
    gd = "git diff";
    ga = "git add";
    gr = "git restore . --staged";
    gcp = "git rev-parse HEAD | tr -d '\\n' | wl-copy && echo \"Copied SHA $(git rev-parse HEAD)\"";
    grp = "git rev-parse HEAD";
    gch = "git checkout";
    gchm = "git checkout main";
  };
}
