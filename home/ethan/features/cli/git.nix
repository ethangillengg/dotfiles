{
  programs.git = {
    enable = true;
    userName = "Ethan Gill";
    userEmail = "gill.ethan123@gmail.com";
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
      format.pretty = "* %C(Yellow)%h %C(reset)%ad (%C(Green)%cr%C(reset)) %C(Cyan)%an %C(reset)(%aE): %C(reset)%s";
      merge.tool = "nvimdiff";
      core.editor = "nvim";
    };

    delta = {
      enable = true;

      options = {
        line-numbers = true;
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        # whitespace-error-style = "22 reverse";
      };
    };
  };
  home.shellAliases = {
    g = "git";
    gp = "git push";
    gs = "git status";
    gsw = "git switch";
    gss = "git status --short";
    gl = "git log";
    gc = "git commit";
    gcm = "git commit -m";
    gca = "git commit --amend"; # ammend with new message
    gcA = "git commit --amend -C HEAD"; # use the previous commit message
    gd = "git diff";
    ga = "git add";
    gr = "git restore . --staged";
    gcp = "git rev-parse HEAD | tr -d '\\n' | wl-copy && echo \"Copied SHA $(git rev-parse HEAD)\"";
    grp = "git rev-parse HEAD";
    gch = "git checkout";
    gchm = "git checkout main";
  };
}
