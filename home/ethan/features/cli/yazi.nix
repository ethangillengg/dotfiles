{pkgs, ...}: let
  # Dependencies
  nvim = "${pkgs.neovim}/bin/nvim";
  #unpack .zip, .tar, .rar with one command
  unar = "${pkgs.unar}/bin/unar";
in {
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        "archive" = [
          {
            exec = "${unar} \"$1\"";
          }
        ];
        "text" = [
          {
            exec = "nvim \"$@\"";
            block = true;
          }
        ];
      };
    };

    theme = {
      # icons = {
      #   "Desktop/" = "";
      #   "Documents/" = "";
      #   "Downloads/" = "";
      #   "Pictures/" = "";
      #   "Music/" = "";
      #   "Movies/" = "";
      #   "Videos/" = "";
      #   "Public/" = "";
      #   "Library/" = "";
      #   "Code/" = "";
      #   ".config/" = "";
      #
      #   # Git;
      #   ".git/" = "";
      #   ".gitignore" = "";
      #   ".gitmodules" = "";
      #   ".gitattributes" = "";
      #
      #   # Dotfiles;
      #   ".DS_Store" = "";
      #   ".bashrc" = "";
      #   ".bashprofile" = "";
      #   ".zshrc" = "";
      #   ".zshenv" = "";
      #   ".zprofile" = "";
      #   ".vimrc" = "";
      #
      #   # Text;
      #   "*.txt" = "";
      #   "*.md" = "";
      #
      #   # Archives;
      #   "*.zip" = "";
      #   "*.tar" = "";
      #   "*.gz" = "";
      #   "*.7z" = "";
      #
      #   # Audio;
      #   "*.mp3" = "";
      #   "*.flac" = "";
      #   "*.wav" = "";
      #
      #   # Movies;
      #   "*.mp4" = "";
      #   "*.mkv" = "";
      #   "*.avi" = "";
      #   "*.mov" = "";
      #
      #   # Images;
      #   "*.jpg" = "";
      #   "*.jpeg" = "";
      #   "*.png" = "";
      #   "*.gif" = "";
      #   "*.webp" = "";
      #   "*.avif" = "";
      #   "*.bmp" = "";
      #   "*.ico" = "";
      #   "*.svg" = "";
      #
      #   # Custom
      #   "*.nix" = "";
      #   "*.key" = "󰌆";
      #   "*.pdf" = "";
      #
      #   # Programming;
      #   "*.c" = "";
      #   "*.cpp" = "";
      #   "*.h" = "";
      #   "*.hpp" = "";
      #   "*.rs" = "";
      #   "*.go" = "";
      #   "*.py" = "";
      #   "*.js" = "";
      #   "*.ts" = "";
      #   "*.tsx" = "";
      #   "*.jsx" = "";
      #   "*.rb" = "";
      #   "*.php" = "";
      #   "*.java" = "";
      #   "*.sh" = "";
      #   "*.fish" = "";
      #   "*.swift" = "";
      #   "*.vim" = "";
      #   "*.lua" = "";
      #   "*.html" = "";
      #   "*.css" = "";
      #   "*.scss" = "";
      #   "*.json" = "";
      #   "*.toml" = "";
      #   "*.yml" = "";
      #   "*.yaml" = "";
      #   "*.ini" = "";
      #   "*.conf" = "";
      #
      #   # Default;
      #   "*" = "";
      #   "*/" = "";
      # };
    };
  };

  home.shellAliases = {
    # "lf" = "yazi";
    # "y" = "yazi";
  };
}
