{config, ...}: {
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
      lfcd = "cd \"$(command lf -print-last-dir \"$@\")\"";
    };

    completionInit = ''
      # Basic auto/tab complete:
      autoload -Uz compinit
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      _comp_options+=(globdots)		# Include hidden files.
      compinit

      # zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
      # fpath=(~/.zsh $fpath)
      # autoload -Uz compinit && compinit
    '';

    initExtra = ''
      # vi mode
      bindkey -v
      export KEYTIMEOUT=1
      export ZVM_CURSOR_STYLE_ENABLED=true

      # Use vim keys in tab complete menu:
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -M menuselect '\e' send-break
      # continue selecting
      bindkey -M menuselect '^\n' accept-and-hold
      bindkey -v '^?' backward-delete-char

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
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

      ## FZF widgets
      fzf-gitadd-widget() {
      # TODO: fix for filenames wrapped in quotes
          local files=$(git -c color.status=always status --short | fzf -m --ansi --preview 'git diff --color=always $(echo {} | cut -c4-)' | cut -c4- | sed 's/ -> /#/' | awk '{print $1}')
          if [ -n "$files" ]; then
              LBUFFER+=" $(echo $files | tr '\n' ' ')"
              zle reset-prompt
          fi
      }
      zle     -N   fzf-gitadd-widget
      bindkey '^g' fzf-gitadd-widget


      bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
      bindkey -s '^p' '^ucd "$(dirname "$(fzf)")"\n'

      # Edit line in vim with ctrl-e:
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^e' edit-command-line
      bindkey -M vicmd '^[[P' vi-delete-char
      bindkey -M vicmd '^e' edit-command-line
      bindkey -M visual '^[[P' vi-delete
    '';
  };
}
