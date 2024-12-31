{
  programs.bash = {
    enable = true;
    # only in login shells. Fix for WSL2 not starting bash with zsh
    profileExtra = "zsh";
  };
}
