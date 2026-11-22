{
  qt = {
    enable = true;
    # "gtk" is deprecated: use "gtk3" for the modern native Qt GTK3 plugin
    # (or "gtk2" to keep the legacy qtstyleplugins behavior).
    platformTheme.name = "gtk3";
  };
}
