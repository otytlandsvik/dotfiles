{ 
  pkgs, 
  lib,
  config, 
  ... 
}:
let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  home.sessionVariables.NIXOS_OZONE_WL = "1";

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
        };
      };
      
      layout = {
        gaps = 16;

        always-center-single-column = true;

        border = {
          enable = false;
          width = 4;
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
        # TODO: Blur comes in v26.04
        # {
        #   matches = [
        #     { app-id = "com.mitchellh.ghostty"; }
        #   ];
        #   # background-effect = { blur = true; };
        #   # opacity = 0.9;
        # }
      ];

      prefer-no-csd = true;

      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+Ctrl+L".action.spawn = noctalia "lockScreen lock";
        "Mod+D".action.spawn = noctalia "launcher toggle";
        "Mod+Shift+Q".action.close-window = [];

        "Mod+H".action.focus-column-left = [];
        "Mod+Left".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+Right".action.focus-column-right = [];

        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+Shift+Up".action.move-window-up = [];
        "Mod+Shift+L".action.move-column-right = [];
        "Mod+Shift+Right".action.move-column-right = [];

        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Shift+Home".action.move-column-to-first = [];
        "Mod+Shift+End".action.move-column-to-last = [];

        "Mod+Comma".action.consume-or-expel-window-left = [];
        "Mod+Period".action.consume-or-expel-window-right = [];

        "Mod+R".action.switch-preset-column-width = [];
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];
        "Mod+C".action.center-column = [];
        "Mod+Shift+C".action.center-visible-columns = [];
        "Mod+V".action.toggle-window-floating = [];

        "Mod+W".action.toggle-column-tabbed-display = [];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+Ctrl+Minus".action.set-window-height = "-10%";
        "Mod+Ctrl+Plus".action.set-window-height = "+10%";

        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";

        "XF86MonBrightnessUp".action.spawn-sh = "brightnessctl set 10%+";
        "XF86MonBrightnessDown".action.spawn-sh = "brightnessctl set 10%-";

        "XF86AudioPlay".action.spawn-sh = "playerctl play-pause";
        "XF86AudioPause".action.spawn-sh = "playerctl pause";
        "XF86AudioNext".action.spawn-sh = "playerctl next";
        "XF86AudioPrev".action.spawn-sh = "playerctl previous";
      };

    };
  };
}
