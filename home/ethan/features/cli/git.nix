{
  programs.git = {
    enable = true;
    userName = "Ethan Gill";
    userEmail = "ethan.gill@ucalgary.ca";
    signing = {
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
