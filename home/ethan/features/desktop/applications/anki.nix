{pkgs, ...}: {
  home.packages = with pkgs; [
    anki-bin
    mecab
    mozcdic-ut-neologd
  ];
}
