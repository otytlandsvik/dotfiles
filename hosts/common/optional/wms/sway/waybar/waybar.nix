{ config, lib, ... }:

let
  palette = config.stylix.base16Scheme;
  paletteStrings = lib.mapAttrsToList (name: value: "@define-color ${name} #${value};") palette;
in
{

  # Manually provide theme colors for css
  xdg.configFile."waybar/colors.css".text = ''
    ${builtins.concatStringsSep "\n" paletteStrings}
  '';

  # Disable stylix to apply own styling
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;

    settings = {
      mainBar =
        let
          baseBar = {
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
              "wireplumber"
              "network"
              (if config.laptop.enable then "battery" else "")
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
              format = "  {:%a %d/%m %R}";
              interval = 60;
            };

            "network" = {
              format-wifi = "  ";
              format-ethernet = "󰛳 ";
              format-disconnected = "󰲛 ";
              tooltip-format-wifi = "{essid} ({signalStrength}%)";
              tooltip-format-ethernet = "{ifname}";
              # TODO: Pass in terminal emulator as a binding for better modularity
              on-click = "networkmanager_dmenu";
              max-length = 20;
            };

            "wireplumber" = {
              format = "{icon}  {volume}% ";
              format-muted = "󰝟 ";
              format-icons = [
                ""
                ""
                ""
              ];
              on-click = "pavucontrol";
            };

            "memory" = {
              format = "  {}%";
              interval = 5;
              on-click = "alacritty -e btop";
            };

            "cpu" = {
              format = "  {usage}%";
              interval = 5;
              on-click = "alacritty -e btop";
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
          laptopModules = {
            "battery" = {
              format = "  {icon}  {capacity}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              interval = 60;
            };
          };
        in
        lib.mkMerge [
          baseBar
          (lib.mkIf config.laptop.enable laptopModules)
        ];
    };

    style = builtins.readFile ./style.css;
  };
}
