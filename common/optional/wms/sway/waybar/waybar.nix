{ config, lib, ... }:

let
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

        modules-left = [
          "sway/workspaces"
          "disk"
          "cpu"
          "memory"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "idle_inhibitor"
          "network"
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

        "network" = {
          format-wifi = " ";
          format-ethernet = "󰛳 ";
          format-disconnected = "󰲛 ";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          max-length = 20;
        };

        # TODO: Might have to use the wireplumber module here instead
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-muted = "󰝟 ";
          format-icons = {
            headphone = " ";
            headset = " ";
            default = [
              " "
              " "
            ];
          };
          on-click = "pavucontrol";
        };

        "memory" = {
          format = "  {}%";
          interval = 5;
        };

        "cpu" = {
          format = "  {}%";
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
            activated = "󰒳 ";
            deactivated = "󰒲 ";
          };
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
