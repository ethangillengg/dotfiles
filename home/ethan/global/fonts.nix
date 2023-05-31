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
      #   family = "FiraCode Nerd Font";
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
      # package = pkgs.nerdfonts;
    };
    regular = {
      # family = "JetBrainsMono Nerd Font";
      family = "JetBrainsMono Nerd Font";
      # package = pkgs.jetbrains-mono;
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
    };
  };
}
