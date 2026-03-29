{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    # ../rofi # dmenu replacement
    # ../rofi/powermenu.nix # Powermenu using rofi
    # ../rofi/networkmanager.nix # Networkmanager using rofi
    # ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    grimblast # Screenshot utility
    playerctl # Media controller
    brightnessctl
    # networkmanagerapplet
  ];

  home.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/screenshots";
  };

  wayland.windowManager.hyprland =
  let
    noctalia = cmd: "noctalia-shell ipc call ${cmd}";
  in
  {
    enable = true;
    settings = {
      "$terminal" = "ghostty";
      "$menu" = noctalia "launcher toggle";

      # Set default scaling
      monitor = config.style.hyprlandMonitorConfig;

      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;
        layout = "master";
      };

      # From noctalia docs
      decoration = {
        rounding = 10;
        rounding_power = 2;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
        };
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
          "workspaces, 1, 3, default"
        ];
      };

      input = {
        kb_layout = "us,no";
        kb_variant = "altgr-intl,";
        kb_options = "grp:win_space_toggle,caps:escape";

        touchpad = lib.mkIf config.laptop.enable {
          natural_scroll = true;
        };

      };

      gestures = lib.mkIf config.laptop.enable {
        gesture = "3, horizontal, workspace";
      };

      windowrulev2 = [
        "float, title:(MainPicker)" # Screensharing picker
        (lib.mkIf config.style.transparency.enable "opacity 0.8, class:(com.mitchellh.ghostty)")
      ];

      layerrule = [
        "blur, noctalia-background-.*$"
        "blurpopups, noctalia-background-.*$"
        "ignorealpha 0.5, noctalia-background-.*$"
      ];

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
              "$mainMod CTRL, L, exec, ${noctalia "lockScreen lock"}"
              "$mainMod, P, exec, ${noctalia "sessionMenu toggle"}"

              ", Print, exec, grimblast copysave area"

              # Move focus
              "$mainMod, H, movefocus, l"
              "$mainMod, Left, movefocus, l"
              "$mainMod, J, movefocus, d"
              "$mainMod, Down, movefocus, d"
              "$mainMod, K, movefocus, u"
              "$mainMod, Up, movefocus, u"
              "$mainMod, L, movefocus, r"
              "$mainMod, Right, movefocus, r"

              # Move across groups
              "$mainMod SHIFT, H, movewindoworgroup, l"
              "$mainMod SHIFT, Left, movewindoworgroup, l"
              "$mainMod SHIFT, J, movewindoworgroup, d"
              "$mainMod SHIFT, Down, movewindoworgroup, d"
              "$mainMod SHIFT, K, movewindoworgroup, u"
              "$mainMod SHIFT, Up, movewindoworgroup, u"
              "$mainMod SHIFT, L, movewindoworgroup, r"
              "$mainMod SHIFT, Right, movewindoworgroup, r"

              # Resize windows
              "$mainMod ALT, H, resizeactive, -10 0"
              "$mainMod ALT, Left, resizeactive, -10 0"
              "$mainMod ALT, J, resizeactive, 0 10"
              "$mainMod ALT, Down, resizeactive, 0 10"
              "$mainMod ALT, K, resizeactive, 0 -10"
              "$mainMod ALT, Up, resizeactive, 0 -10"
              "$mainMod ALT, L, resizeactive, 10 0"
              "$mainMod ALT, Right, resizeactive, 10 0"

              # Master layout
              "$mainMod, M, layoutmsg, swapwithmaster"
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
            ", switch:Lid Switch, exec, ${noctalia "lockScreen lock"}"
          ];
        in
        lib.mkMerge [
          baseBindings
          (lib.mkIf config.laptop.enable laptopBindings)
        ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
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

      # Start utilities on launch
      exec-once = [
        "noctalia-shell"
      ];
    };
  };
}
