{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    # monospace = {
    #   family = "FiraCode Nerd Font";
    #   package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    # };
    # regular = {
    #   family = "Fira Sans";
    #   package = pkgs.fira;
    # };

    monospace = {
      family = "JetBrainsMono Nerd Font";
      # family = "Fira Code Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
    };
    regular = {
      family = "JetBrainsMono Nerd Font";
      # family = "Fira Code Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
    };
    fallback = {
      family = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk;
    };
  };
}
