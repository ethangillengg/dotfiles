# Runs youtube-music wrapped in a new firefox window
{
  lib,
  writeShellApplication,
  firefox,
}:
(writeShellApplication {
  name = "yt-music";
  runtimeInputs = [firefox];
  text = builtins.readFile ./yt-music.sh;
})
// {
  meta = with lib; {
    description = "Runs YouTube Music in a new Firefox window";
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
