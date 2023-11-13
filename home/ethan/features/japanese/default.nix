{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    qolibri
    mupdf
    calibre
    unbook
  ];
}
