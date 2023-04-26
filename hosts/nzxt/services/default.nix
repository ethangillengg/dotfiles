{ outputs, ... }:
{
  imports = [
    ./jellyfin
    ./qbittorrent
  ] ++ (builtins.attrValues outputs.nixosModules);
}

