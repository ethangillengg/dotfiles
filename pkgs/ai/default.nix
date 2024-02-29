# Repl for mods to interact with chatgpt
{
  lib,
  writeShellApplication,
  pass,
  mods,
}:
(writeShellApplication {
  name = "ai";
  runtimeInputs = [pass mods];
  text = builtins.readFile ./ai.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
