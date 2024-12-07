{pkgs, ...}: {
  fontProfiles = {
    enable = true;

    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    regular = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
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
    nerd-fonts.fira-code
  ];
}
