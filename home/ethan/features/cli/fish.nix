{pkgs, ...}: let
  # Dependencies
  quote = "${pkgs.quote}/bin/quote";
  nitch = "${pkgs.nitch}/bin/nitch";
  gum = "${pkgs.gum}/bin/gum";
in {
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "${nitch}";
      lfcd = ''
        set tmp (mktemp)
        # `command` is needed in case `lfcd` is aliased to `lf`
        command lf -last-dir-path=$tmp $argv
        if test -f "$tmp"
            set dir (cat $tmp)
            rm -f $tmp
            if test -d "$dir"
                if test "$dir" != (pwd)
                    cd $dir
                end
            end
        end
      '';
    };
  };
}
