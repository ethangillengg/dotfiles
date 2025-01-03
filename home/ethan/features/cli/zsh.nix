{
  pkgs,
  config,
  ...
}: let
  gitDiffAllFilesPkg = pkgs.writeShellScriptBin "git-diff-all-files" ''
    #!/usr/bin/env bash
    FILE_PATH=$(echo "$1" | awk '{$1=""; sub(/^ +/, ""); print}')
    # print the diff, removing the file header
    DIFF=$(git diff HEAD --color=always -- "$FILE_PATH" | tail -n +5)
    if [[ $DIFF ]]; then
        echo $FILE_PATH
        echo "$DIFF"
    else
    # Prints the untracked file all in green
      RESET="\033[0m"
      GREEN="\033[32m"
      echo $FILE_PATH
      while IFS= read -r line; do
        echo -e "$GREEN$line$RESET"
      done < "$FILE_PATH"
    fi
  '';
  gitDiffAllFiles = "${gitDiffAllFilesPkg}/bin/git-diff-all-files";
in {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 1000000;
      save = 1000000;
    };

    # Expand aliases when used
    zsh-abbr = {
      enable = true;
      abbreviations = config.home.shellAliases;
    };

    shellAliases = {
      # custom file broswer
      fj = "yacd";
      rm = "nocorrect rm";
    };

    # Plugin manager
    prezto = {
      enable = true;
      editor.keymap = "vi";
      prompt.theme = "pure";
    };

    initExtra = ''
      # Change cursor shape for different vi modes.
      function zle-keymap-select () {
          case $KEYMAP in
              vicmd) echo -ne '\e[1 q';;      # block
              viins|main) echo -ne '\e[5 q';; # beam
          esac
      }
      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prom


      fzf-gitadd-widget() {
      # TODO: fix for filenames wrapped in quotes
          local files=$(git -c color.status=always status --short | fzf -m --ansi --preview '${gitDiffAllFiles} {}' --preview-window '65%' | cut -c4- | sed 's/ -> /#/' | awk '{print $1}')
          if [ -n "$files" ]; then
              LBUFFER+=" $(echo $files | tr '\n' ' ')"
              zle reset-prompt
          fi
      }
      zle     -N   fzf-gitadd-widget
      bindkey '^g' fzf-gitadd-widget
      bindkey '^e' fzf-gitadd-widget

      # editor for edit-command-line
      export VISUAL="nvim --clean"
      bindkey '^e' edit-command-line
      bindkey -M vicmd "^e" edit-command-line

      # yazi change dir
      function yacd() {
        tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };
}
