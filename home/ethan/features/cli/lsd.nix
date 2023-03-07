{
  programs.lsd = {
    enable = true;
    settings = {
      blocks = [
        "permission"
        "user"
        "size"
        "date"
        "name"
      ];
      date = "relative";
      ignore-globs = [
        ".git"
      ];
      recursion.depth = 2;
      sorting.dir-grouping = "first";
      hyperlink = "auto";
      header = true;
    };
  };
}
