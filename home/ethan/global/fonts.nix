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
  };

  # Extra fonts
  home.packages = with pkgs; [
    fontpreview # easy font preview
    rictydiminished-with-firacode
  ];
}
