{
  lib,
  writeShellApplication,
  swww,
}:
(writeShellApplication {
  name = "random-wallpaper";
  runtimeInputs = [swww];
  text = builtins.readFile ./random-wallpaper.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
