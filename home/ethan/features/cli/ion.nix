{
  # not working due to https://github.com/ajeetdsouza/zoxide/issues/66 :((
  programs.ion = {

    enable = false;


    initExtra = ''
      fn _z_cd argv:[str]
          cd @argv
          exists -s _ZO_ECHO && echo $PWD
      end

      fn z argv:[str]
          match @argv
              case [ - ]
                  _z_cd [ @argv ]
              case _
                  let result = $(zoxide query @argv)
                  if test -d $result
                      _z_cd [ $result ]
                  else if test -n $result
                      echo $result
                  end
          end
      end

      alias zi='z -i'
      alias za='zoxide add'
      alias zq='zoxide query'
      alias zr='zoxide remove'
    '';
    # shellAliases = {
    #   z = "zoxide query";
    #   zi = "z -i";
    #   zq = "zoxide query";
    #   zr = "zoxide remove";
    # };
  };
}

