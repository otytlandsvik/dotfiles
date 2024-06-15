{ ... }:
{
  # Customizable status bar written in rust
  programs.i3status-rust = {
    enable = true;

    bars."statusbar" = {
      blocks = [
        {
          block = "focused_window";
          format = " $title.str(max_w:45) | ";
          driver = "sway_ipc";
        }
        {
          block = "disk_space";
          info_type = "available";
          path = "/";
          interval = 60;
          alert = 10.0;
          warning = 20.0;
        }
        {
          block = "memory";
          format = " $icon $mem_used_percents ";
          format_alt = " $icon $swap_used_percents ";
        }
        {
          block = "cpu";
          interval = 1;
        }
        { block = "sound"; }
        # TODO: Add kblayout block with proper mappings
        # {
        #   block = "keyboard_layout";
        #   format = " $layout ";
        #   driver = "sway";
        #   mappings = {
        #     "English" = "en";
        #     "Norwegian" = "no";
        #   };
        # }
        {
          block = "time";
          interval = 60;
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
        }
      ];
      icons = "awesome5";
      theme = "ctp-mocha";
    };
  };
}
