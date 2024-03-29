{pkgs, ...}: {
  fontProfiles = {
    enable = true;

    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
    };

    regular = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];};
    };

    fallback = {
      family = "Rounded Mgen+ 1c";
      package = pkgs.rounded-mgenplus;
    };

    emoji = {
      family = "Twitter Color Emoji";
      package = pkgs.twitter-color-emoji;
    };
  };

  # Extra fonts
  home.packages = with pkgs; [
    fontpreview # easy font preview
  ];
}
