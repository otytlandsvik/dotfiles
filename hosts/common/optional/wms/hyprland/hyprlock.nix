{ lib, config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      # Blurred snapshot of desktop
      background = {
        path = lib.mkForce "screenshot";
        blur_passes = 3;
        blur_size = 8;
      };

      # Display time
      label = with config.stylix.base16Scheme; [
        {
          text = ''cmd[update:1000] echo "$(date +"%H")"'';
          font_size = 90;
          font_family = "JetBrains Mono Extrabold Italic";
          color = "rgb(${base0D})";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo "$(date +"%M")"'';
          font_size = 90;
          font_family = "JetBrains Mono Extrabold Italic";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
        {
          text = ''
            cmd[update:60000] echo "<span foreground='##${base0D}'>$(date +"%A"),</span> $(date +"%d") $(date +"%b")"
          '';
          font_size = 24;
          font_family = "JetBrains Mono";
          position = "0, -15";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = {
        size = "400, 50";
        position = "0, -80";
        fade_on_empty = false;
        placeholder_text = "<i>Password...</i>";
      };
    };
  };
}
