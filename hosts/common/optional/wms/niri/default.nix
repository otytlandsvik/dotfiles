{
  pkgs,
  lib,
  config,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [
    ../hypridle.nix
    ./screenshot.nix
    ./screen-mirror.nix
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
  };

  home.packages = with pkgs; [
    wl-clipboard
    playerctl
    brightnessctl
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {

      input = {
        keyboard.xkb = {
          layout = "us,no";
          variant = "altgr-intl,";
          options = "grp:win_space_toggle,caps:escape";
        };
        touchpad = lib.mkIf config.laptop.enable {
          natural-scroll = true;
          dwt = true; # Disable while typing
        };
      };

      layout = {
        gaps = 10;
        always-center-single-column = true;

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        default-column-width = lib.mkMerge [
          (lib.mkIf config.laptop.enable {
            proportion = 2.0 / 3.0;
          })
          (lib.mkIf (!config.laptop.enable) {
            proportion = 1.0 / 2.0;
          })
        ];

        preset-window-heights = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        focus-ring = {
          width = 3;
          active.gradient = with config.lib.stylix.colors.withHashtag; {
            from = base0D;
            to = base0B;
            angle = 135;
          };
        };

      };

      outputs."eDP-1".scale = 1.0;

      window-rules = [
        {
          geometry-corner-radius =
            let
              radius = 8.0;
            in
            {
              top-left = radius;
              top-right = radius;
              bottom-left = radius;
              bottom-right = radius;
            };

          clip-to-geometry = true;
        }
        {
          matches = [
            { app-id = "org.pulseaudio.pavucontrol"; }
          ];
          open-floating = true;
          default-column-width = {
            proportion = 1.0 / 3.0;
          };
          default-window-height = {
            proportion = 1.0 / 2.0;
          };
        }
        # TODO: Blur comes in v26.04
        # {
        #   matches = [
        #     { app-id = "com.mitchellh.ghostty"; }
        #   ];
        #   # background-effect = { blur = true; };
        #   # opacity = 0.9;
        # }
      ];

      layer-rules = [
        {
          matches = [
            { namespace = "^noctalia-overview*"; }
          ];
          place-within-backdrop = true;
        }
      ];

      # Tell clients that they are being tiled, so they don't render decorations
      prefer-no-csd = true;

      overview.zoom = 0.75;

      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];

      hotkey-overlay.skip-at-startup = true;

      switch-events = lib.mkIf config.laptop.enable {
        lid-close.action.spawn = noctalia "lockScreen lock";
      };

      binds = {
        "Mod+Return" = {
          action.spawn = "ghostty";
          repeat = false;
        };
        "Mod+Alt+L".action.spawn = noctalia "lockScreen lock";
        "Mod+D".action.spawn = noctalia "launcher toggle";
        "Mod+P".action.spawn = noctalia "sessionMenu toggle";
        "Mod+Shift+P" = {
          action.spawn-sh = "niri-mirror";
          repeat = false;
        };
        "Mod+Shift+Q" = {
          action.close-window = [ ];
          repeat = false;
        };

        "Mod+O" = {
          action.toggle-overview = [ ];
          repeat = false;
        };

        # Screenshot with custom script
        "Print".action.spawn-sh = "niri-screenshot region";
        "Mod+S".action.spawn-sh = "niri-screenshot window";
        "Mod+Ctrl+S".action.spawn-sh = "niri-screenshot monitor";

        # Move focus between columns/windows
        "Mod+H".action.focus-column-left-or-last = [ ];
        "Mod+Left".action.focus-column-left-or-last = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+L".action.focus-column-right-or-first = [ ];
        "Mod+Right".action.focus-column-right-or-first = [ ];

        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];

        # Move focus between workspaces
        "Mod+U".action.focus-workspace-down = [ ];
        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+I".action.focus-workspace-up = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];

        # Move focus between monitors
        "Mod+Ctrl+H".action.focus-monitor-left = [ ];
        "Mod+Ctrl+Left".action.focus-monitor-left = [ ];
        "Mod+Ctrl+J".action.focus-monitor-down = [ ];
        "Mod+Ctrl+Down".action.focus-monitor-down = [ ];
        "Mod+Ctrl+K".action.focus-monitor-up = [ ];
        "Mod+Ctrl+Up".action.focus-monitor-up = [ ];
        "Mod+Ctrl+L".action.focus-monitor-right = [ ];
        "Mod+Ctrl+Right".action.focus-monitor-right = [ ];

        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [ ];
          cooldown-ms = 150;
        };

        # NOTE: We don't want to wrap around here, because it's easy to overhoot with the scroll wheel
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];

        # Move window/column
        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+J".action.move-window-down = [ ];
        "Mod+Shift+Down".action.move-window-down = [ ];
        "Mod+Shift+K".action.move-window-up = [ ];
        "Mod+Shift+Up".action.move-window-up = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];

        "Mod+Shift+Home".action.move-column-to-first = [ ];
        "Mod+Shift+End".action.move-column-to-last = [ ];

        # Move window/column between workspaces
        "Mod+Shift+U".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+I".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+Page_Up".action.move-column-to-workspace-up = [ ];

        # Move window/column between monitors
        "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = [ ];
        "Mod+Ctrl+Shift+Left".action.move-column-to-monitor-left = [ ];
        "Mod+Ctrl+Shift+J".action.move-column-to-monitor-down = [ ];
        "Mod+Ctrl+Shift+Down".action.move-column-to-monitor-down = [ ];
        "Mod+Ctrl+Shift+K".action.move-column-to-monitor-up = [ ];
        "Mod+Ctrl+Shift+Up".action.move-column-to-monitor-up = [ ];
        "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = [ ];
        "Mod+Ctrl+Shift+Right".action.move-column-to-monitor-right = [ ];

        # Move window across columns
        "Mod+Comma".action.consume-or-expel-window-left = [ ];
        "Mod+Period".action.consume-or-expel-window-right = [ ];

        "Mod+W".action.toggle-column-tabbed-display = [ ];

        # Shrink/Grow window/column
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+Shift+C".action.center-visible-columns = [ ];
        "Mod+V".action.toggle-window-floating = [ ];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Go to workspace
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # Move column to workspace
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # Media controls
        "XF86AudioLowerVolume" = {
          action.spawn = noctalia "volume decrease";
          allow-when-locked = true;
        };
        "XF86AudioRaiseVolume" = {
          action.spawn = noctalia "volume increase";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = noctalia "volume muteOutput";
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp" = {
          action.spawn-sh = "brightnessctl set 10%+";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn-sh = "brightnessctl set 10%-";
          allow-when-locked = true;
        };

        "XF86AudioPlay" = {
          action.spawn-sh = "playerctl play-pause";
          allow-when-locked = true;
        };
        "XF86AudioPause" = {
          action.spawn-sh = "playerctl pause";
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn-sh = "playerctl next";
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn-sh = "playerctl previous";
          allow-when-locked = true;
        };
      };

    };
  };
}
