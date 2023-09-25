{
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
      options = {
        line-numbers = true;
        side-by-side = true;
      };
    };

    aliases = {
      graph = "log --decorate --oneline --graph";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
