{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ../waybar
    ../rofi # dmenu replacement
    ../rofi/powermenu.nix # Powermenu using rofi
    ../rofi/networkmanager.nix # Networkmanager using rofi
    ../mako.nix # Notification daemon
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    grimblast # Screenshot utility
    playerctl # Media controller
    brightnessctl
    # TODO: Make use of nm-tray
    nm-tray
  ];

  # Required to render waybar properly
  wms.waybar.windowManager = "hyprland";

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";

      # Set default scaling
      monitor = ", preferred, auto, 1";

      general = {
        border_size = 2;
        gaps_in = 0;
        gaps_out = 0;
        layout = "master";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input =
        let
          mkIfLaptop =
            laptopOpts: otherOpts:
            lib.mkMerge [
              (lib.mkIf config.laptop.enable laptopOpts)
              (lib.mkIf (!config.laptop.enable) otherOpts)
            ];
        in
        {
          kb_layout = mkIfLaptop "us,no" "us";
          kb_variant = mkIfLaptop "altgr-intl," "altgr-intl";

          touchpad = lib.mkIf config.laptop.enable {
            natural_scroll = true;
          };

        };

      gestures = lib.mkIf config.laptop.enable {
        workspace_swipe = true;
      };

      "$mainMod" = "SUPER";

      bind =
        let
          baseBindings =
            [
              "$mainMod, RETURN, exec, $terminal"
              "$mainMod, V, togglefloating,"
              "$mainMod, F, fullscreen,"
              "$mainMod, D, exec, $menu"
              "$mainMod, X, exec, firefox"
              "$mainMod, W, togglegroup,"
              "$mainMod SHIFT, Q, killactive,"
              "$mainMod CTRL, L, exec, hyprlock --immediate"
              "$mainMod SHIFT, P, exec, rofi-powermenu"

              ", Print, exec, grimblast copysave area"

              # Move focus
              "$mainMod, H, movefocus, l"
              "$mainMod, J, movefocus, d"
              "$mainMod, K, movefocus, u"
              "$mainMod, L, movefocus, r"

              # Move across groups
              "$mainMod SHIFT, H, movewindoworgroup, l"
              "$mainMod SHIFT, J, movewindoworgroup, d"
              "$mainMod SHIFT, K, movewindoworgroup, u"
              "$mainMod SHIFT, L, movewindoworgroup, r"

              # Master layout
              "$mainMod, P, layoutmsg, swapwithmaster"
              "$mainMod, BACKSPACE, layoutmsg, orientationnext"

              # Cycle windows
              "$mainMod, TAB, cyclenext,"
              "$mainMod, TAB, changegroupactive, f"

              # Move between monitors
              "$mainMod SHIFT, RETURN, movecurrentworkspacetomonitor, +1"

              # Scratchpad
              "$mainMod, S, togglespecialworkspace, magic"
              "$mainMod SHIFT, S, movetoworkspace, special:magic"
            ]
            ++ (
              # Go to / move to workspace [1..9]
              builtins.concatLists (
                builtins.genList (
                  i:
                  let
                    ws = i + 1;
                  in
                  [
                    "$mainMod, ${toString ws}, workspace, ${toString ws}"
                    "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
                  ]
                ) 9
              )
            );
          laptopBindings = [
            ", switch:Lid Switch, exec, hyprlock"
          ];
        in
        lib.mkMerge [
          baseBindings
          (lib.mkIf config.laptop.enable laptopBindings)
        ];

      # Bindings that repeat when held down
      binde = [
        ", XF86MonBrightnessUp,   exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        ", XF86AudioMute,         exec, pamixer --toggle-mute"
        ", XF86AudioRaiseVolume,  exec, pamixer -ui 5"
        ", XF86AudioLowerVolume,  exec, pamixer -ud 5"
      ];

      # Bindings allowed when locked
      bindl = [
        # Media control
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl pause"
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];

      # Waybar
      exec-once = [
        "waybar"
      ];
    };
  };
}
