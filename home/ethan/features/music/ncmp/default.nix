{
  config,
  pkgs,
  ...
}: let
  songinfo = pkgs.writeShellScriptBin "songinfo" ''
    music_dir="$HOME/Music"
    previewdir="$XDG_CONFIG_HOME/ncmpcpp/previews"
    filename="$(${pkgs.mpc-cli}/bin/mpc --format "$music_dir"/%file% current)"
    previewname="$previewdir/$(${pkgs.mpc-cli}/bin/mpc --format %album% current | base64).png"

    [ -e "$previewname" ] || ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$filename" -an -vf scale=128:128 "$previewname" > /dev/null 2>&1

    ${pkgs.libnotify}/bin/notify-send -r 27072 "Now Playing" "$(${pkgs.mpc-cli}/bin/mpc --format '%title% \n%artist% - %album%' current)" -i "$previewname"
  '';
in {
  programs.ncmpcpp = {
    enable = false;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };

    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }

      {
        key = "alt-j";
        command = "move_selected_items_down";
      }
      {
        key = "alt-k";
        command = "move_selected_items_up";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "J";
        command = ["select_item" "scroll_down"];
      }
      {
        key = "K";
        command = ["select_item" "scroll_up"];
      }
      {
        key = "d";
        command = ["delete_playlist_items"];
      }
    ];

    settings = {
      # Miscelaneous
      ncmpcpp_directory = "${config.home.homeDirectory}/.config/ncmpcpp";
      ignore_leading_the = true;
      external_editor = "nvim";
      message_delay_time = 1;
      playlist_disable_highlight_delay = 2;
      autocenter_mode = "yes";
      centered_cursor = "yes";
      allow_for_physical_item_deletion = "no";
      lines_scrolled = "0";
      follow_now_playing_lyrics = "yes";
      execute_on_song_change = "${songinfo}/bin/songinfo";
      # "${notify-send} \"Now Playing\" \"$(${mpc} --format '%title% \\n%artist% - %album%' current)\"";

      # visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_type = "ellipse";
      visualizer_look = "●●";
      visualizer_color = "blue, green";

      # appearance
      colors_enabled = "yes";
      playlist_display_mode = "classic";
      user_interface = "classic";
      volume_color = "white";

      # window
      song_window_title_format = "Music";
      statusbar_visibility = "yes";
      header_visibility = "yes";
      titles_visibility = "yes";

      # progress bar
      # progressbar_look = "─╼ ";
      progressbar_look = "▃▃▃";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";

      # song list
      song_status_format = "$7%t";
      song_list_format = "$(008)%t$R  $(247)%a$R$5  %l$8";
      song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";

      current_item_prefix = "$(yellow)$r";
      current_item_suffix = "$/r$(end)";

      now_playing_prefix = "$b$5| ";
      now_playing_suffix = "$/b$5";

      song_library_format = "{{%a - %t} (%b)}|{%f}";

      # colors
      main_window_color = "blue";

      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";

      color1 = "white";
      color2 = "blue";
    };
  };
}
