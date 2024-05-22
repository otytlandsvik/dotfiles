{ config, lib, ... }:

let
  inherit config;
  palette = config.stylix.base16Scheme;
  paletteStrings = lib.mapAttrsToList (name: value: "@define-color ${name} #${value};") palette;
in
{

  # Manually provide theme colors to for css
  xdg.configFile."waybar/colors.css".text = ''
    ${builtins.concatStringsSep "\n" paletteStrings}
  '';

  # Disable stylix to apply own styling
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;

        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "idle_inhibitor"
          "disk"
          "cpu"
          "memory"
          "clock"
          "tray"
        ];

        "sway/window" = {
          format = "{title}";
          max-length = 50;
          # NOTE: Long dash used by some sway windows: — 
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Discord" = "  $1";
            "Ferdium - (.*)" = " $1";
          };
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
        };

        "clock" = {
          format = "{:%a %d/%m %R}";
          interval = 60;
        };

        "memory" = {
          format = "  {}%";
          interval = 5;
        };

        "cpu" = {
          format = "  {}%";
          interval = 5;
        };

        "disk" = {
          format = "󰆼 {free}";
          unit = "GB";
          interval = 30;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
