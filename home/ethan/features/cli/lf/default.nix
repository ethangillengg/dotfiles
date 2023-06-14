{pkgs, ...}: {
  home.packages = with pkgs; [
    trashy
    file
    perl536Packages.FileMimeInfo # for mime-type open
    ctpv
    pistol
    chafa
  ];

  xdg.configFile."lf/icons".source = ./icons;
  xdg.configFile."lf/colors".source = ./colors;
  # See https://github.com/gokcehan/lf/wiki/Previews#with-kitty-and-pistol
  xdg.configFile."lf/preview".source = ./preview.sh;
  xdg.configFile."lf/clean".source = ./clean.sh;
  # xdg.configFile."ctpv/config".source = ./cptv;

  programs.lf = {
    enable = true;

    extraConfig = ''
      set previewer ~/.config/lf/preview
      set cleaner ~/.config/lf/clean

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

      "<delete>" = "trash";
      "R" = ":bulk-rename";
    };

    commands = {
      "mkdir" = "%mkdir \"$@\"";
      "touch" = "%touch \"$@\"";

      # "open" = "$nvim $fx";
      "open" = ''
        cmd open ''${{
            case $(file --mime-type -Lb $f) in
                text/*) nvim $fx;;
                *) for f in $fx; do mimeopen $f > /dev/null 2> /dev/null & done;;
            esac
        }}
      '';
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

      "trash" = "%trash put $fx";
    };

    settings = {
      drawbox = true;
      icons = true;
    };
  };
}
