{
  lib,
  writeShellApplication,
  awww,
}:
(writeShellApplication {
  name = "random-wallpaper";
  runtimeInputs = [awww];
  text = builtins.readFile ./random-wallpaper.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
