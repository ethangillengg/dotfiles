{
  fetchurl,
  chromium,
  lib,
  makeDesktopItem,
  runtimeShell,
  symlinkJoin,
  writeScriptBin,
  # command line arguments which are always set e.g "--disable-gpu"
  commandLineArgs ? [],
}: let
  name = "yt-music";

  meta = {
    description = "Open YouTube Music in Google Chrome app mode";
    longDescription = ''
      This package installs an application launcher item that opens YouTube Music in a dedicated Google Chrome window.
    '';
    homepage = chromium.meta.homepage or null;
    license = lib.licenses.unfree;
    platforms = chromium.meta.platforms or lib.platforms.all;
  };

  desktopItem = makeDesktopItem {
    inherit name;
    # Executing by name as opposed to store path is conventional and prevents
    # copies of the desktop file from bitrotting too much.
    # (e.g. a copy in ~/.config/autostart, you lazy lazy bastard ;) )
    exec = name;
    icon = fetchurl {
      name = "netflix-icon-2016.png";
      url = "https://i.imgur.com/d6EGYgu.png";
      sha256 = "sha256-GTpH1pX4Yz7iAAd6jEW9/4SiU7+F4f6+SxpU7N2TxNg=";
      meta.license = lib.licenses.unfree;
    };
    desktopName = "YouTube Music";
    genericName = "A music streaming service by Google";
    categories = ["AudioVideo" "Music" "Network"];
    startupNotify = true;
  };

  script = writeScriptBin name ''
    #!${runtimeShell}
    exec ${chromium}/bin/${chromium.meta.mainProgram} ${lib.escapeShellArgs commandLineArgs} \
      --app=https://music.youtube.com \
      --no-first-run \
      --no-default-browser-check \
      --no-crash-upload \
      # "$@"
  '';
in
  symlinkJoin {
    inherit name meta;
    paths = [script desktopItem];
  }
