{pkgs, ...}: {
  home.packages = with pkgs; [
    mupdf
  ];
}
