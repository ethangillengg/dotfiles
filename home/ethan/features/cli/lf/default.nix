{pkgs, ...}: let
  # Dependencies
  fd = "${pkgs.fd}/bin/fd";
  fzf = "${pkgs.fzf}/bin/fzf";
  trashy = "${pkgs.trashy}/bin/trash";
  trash-put = "${trashy} put";

  ctpv = "${pkgs.ctpv}/bin/ctpv";
  ctpvclear = "${pkgs.ctpv}/bin/ctpvclear";
  ctpvquit = "${pkgs.ctpv}/bin/ctpvquit";
in {
  xdg.configFile."lf/icons".source = ./icons;
  xdg.configFile."lf/colors".source = ./colors;
  xdg.configFile."ctpv/config".source = ./cptv;

  programs.lf = {
    enable = true;

    extraConfig = ''
      set previewer ${ctpv}
      set cleaner ${ctpvclear}
      &${ctpv} -s $id
      &${ctpvquit} $id

      set sixel true
      set drawbox
      set ratios 2:5:5
      set info size
      set incfilter
      set incsearch
      set scrolloff 10 # leave some space at the top and the bottom of the screen
      set shellopts '-eu'
      set ifs "\n"
    '';

    keybindings = {
      "<enter>" = ":open";

      "<esc>" = ":setfilter";
      "f" = ":filter";
      "A" = "push :mkdir<space>";
      "a" = "push :touch<space>";

      "H" = ":set hidden!";

      "<delete>" = ":trash";
      "R" = ":bulk-rename";

      "<c-f>" = ":fzf_jump";
    };

    commands = {
      "mkdir" = "%mkdir \"$@\"";
      "touch" = "%touch \"$@\"";

      "open" = "$nvim $fx";
      # "open" = ''
      #   cmd open ''${{
      #       case $(${file} --mime-type -Lb $f) in
      #           text/*) nvim $fx;;
      #           *) for f in $fx; do mimeopen $f > /dev/null 2> /dev/null & done;;
      #       esac
      #   }}
      # '';
      "bulk-rename" = ''
        ''${{
            old="$(mktemp)"
            new="$(mktemp)"
            if [ -n "$fs" ]; then
                fs="$(basename -a $fs)"
            else
                fs="$(ls)"
            fi
            printf '%s\n' "$fs" >"$old"
            printf '%s\n' "$fs" >"$new"
            nvim "$new"
            [ "$(wc -l < "$new")" -ne "$(wc -l < "$old")" ] && exit
            paste "$old" "$new" | while IFS= read -r names; do
                src="$(printf '%s' "$names" | cut -f1)"
                dst="$(printf '%s' "$names" | cut -f2)"
                if [ "$src" = "$dst" ] || [ -e "$dst" ]; then
                    continue
                fi
                mv -- "$src" "$dst"
            done
            rm -- "$old" "$new"
            lf -remote "send $id unselect"
        }}
      '';

      "trash" = "%${trash-put} $fx";

      "fzf_jump" = ''
        ''${{
              res="$(${fd} . --hidden --exclude ".git" | ${fzf} --reverse --header='Jump to location' --preview '${ctpv} {}')"
              if [ -n "$res" ]; then
                  if [ -d "$res" ]; then
                      cmd="cd"
                  else
                      cmd="select"
                  fi
                  res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
                  lf -remote "send $id $cmd \"$res\""
              fi
          }}
      '';
    };

    settings = {
      drawbox = true;
      icons = true;
    };
  };
}
