{ config, lib, ... }:

let
  palette = config.stylix.base16Scheme;
  paletteStrings = lib.mapAttrsToList (name: value: "@define-color ${name} #${value};") palette;
in
{
  options.wms.waybar = {
    windowManager = lib.mkOption {
      type = lib.types.str;
      default = "sway";
      description = "Window manager to use with waybar. Can be 'sway' or 'hyprland'";
    };
    swayncBell.enable = lib.mkEnableOption "add notification module to access the swaync notification center";
  };

  config = {
    # Manually provide theme colors for css
    xdg.configFile."waybar/colors.css".text = ''
      ${builtins.concatStringsSep "\n" paletteStrings}
    '';

    # Disable stylix to apply own styling
    stylix.targets.waybar.enable = false;

    programs.waybar =
      let
        wm = config.wms.waybar.windowManager;
      in
      {
        enable = true;

        settings = {
          mainBar =
            let
              baseBar = {
                layer = "bottom";
                position = "top";
                height = 30;

                modules-left = [
                  "${wm}/workspaces"
                  "disk"
                  "cpu"
                  "memory"
                ];
                modules-center = [ "${wm}/window" ];
                modules-right = [
                  "idle_inhibitor"
                  "wireplumber"
                  "network"
                  (if config.laptop.enable then "battery" else "")
                  "clock"
                  (if config.wms.waybar.swayncBell.enable then "custom/notification" else "")
                  "tray"
                ];

                "${wm}/window" = {
                  format = "{title}";
                  max-length = 50;
                  # NOTE: Long dash used by some windows: —
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
                  on-click = "ghostty -e btop";
                };

                "cpu" = {
                  format = "  {usage}%";
                  interval = 5;
                  on-click = "ghostty -e btop";
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
              swayncBellModule = {
                "custom/notification" = {
                  tooltip = false;
                  format = "{icon} ";
                  format-icons = {
                    "notification" = "<span class='unread'><sup></sup></span>";
                    "none" = "";
                    "dnd-notification" = "<span class='unread'><sup></sup></span>";
                    "dnd-none" = "";
                    "inhibited-notification" = "<span class='unread'><sup></sup></span>";
                    "inhibited-none" = "";
                    "dnd-inhibited-notification" = "<span class='unread'><sup></sup></span>";
                    "dnd-inhibited-none" = "";
                  };
                  return-type = "json";
                  exec-if = "which swaync-client";
                  exec = "swaync-client -swb";
                  on-click = "swaync-client -t -sw";
                  on-click-right = "swaync-client -d -sw";
                  escape = true;
                };
              };
            in
            lib.mkMerge [
              baseBar
              (lib.mkIf config.laptop.enable laptopModules)
              (lib.mkIf config.wms.waybar.swayncBell.enable swayncBellModule)
            ];
        };

        style = builtins.readFile ./style.css;
      };
  };
}
