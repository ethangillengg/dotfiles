{config, ...}: {
  services.git-sync = {
    enable = true;
    repositories = {
      # Syncs my notes every 500 seconds (home manager default)
      # or when the files are changed
      notes = {
        path = config.home.homeDirectory + "/Notes";
        uri = "git@github.com:ethangillengg/notes.git";
      };
    };
  };
}
