{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./waybar/waybar.nix
    ./rofi # dmenu replacement
    ./rofi/powermenu.nix # powermenu using rofi
    ./rofi/networkmanager.nix # networkmanager using rofi
    ./mako.nix # notification daemon
    ./swaylock.nix
    ./swayidle.nix
  ];

  options.wms.sway = {
    outputConfig = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Settings passed to sway.config.output, for configuring displays";
    };
  };

  config = {
    # Sway related packages
    home.packages =
      with pkgs;
      let
        basePackages = [
          wl-clipboard # Clipboard manager
          sway-contrib.grimshot # Screenshot utility
          playerctl # Media controller
        ];
        laptopPackages = [ brightnessctl ];
      in
      lib.mkMerge [
        basePackages
        (lib.mkIf config.laptop.enable laptopPackages)
      ];

    wayland.windowManager.sway = {
      enable = true;
      package = null;

      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        defaultWorkspace = "workspace number 1";

        # Sway overrides xkb config from system
        input =
          let
            keyboardCfg = {
              "type:keyboard" = {
                xkb_layout = "us,no";
                xkb_variant = "altgr-intl,";
                xkb_options = "grp:win_space_toggle,caps:escape_shifted_capslock";
              };
            };
            touchpadCfg = {
              "type:touchpad" = {
                tap = "enabled";
                natural_scroll = "enabled";
              };
            };
          in
          lib.mkMerge [
            keyboardCfg
            (lib.mkIf config.laptop.enable touchpadCfg)
          ];

        # Use output config passed from caller
        output = config.wms.sway.outputConfig;

        # Styling overrides
        colors = with config.stylix.base16Scheme; {
          focused = lib.mkOptionDefault {
            border = lib.mkForce "#${base0D}";
            childBorder = lib.mkForce "#${base0D}";
            indicator = lib.mkForce "#${base0C}";
          };
        };

        menu = "${pkgs.rofi}/bin/rofi -show drun";

        keybindings =
          let
            mod = config.wayland.windowManager.sway.config.modifier;
            # NOTE: mkOptionDefault to extend/override instead of overwriting all keybindings
            baseKeys = lib.mkOptionDefault {
              # Engage swaylock
              "${mod}+Ctrl+l" = "exec swaylock";

              # Screenshots
              "Print" = "exec grimshot savecopy anything";

              # Open firefox
              "${mod}+x" = "exec firefox";

              # Open powermenu
              "${mod}+p" = "exec rofi-powermenu";

              # Move workspace to other output
              "${mod}+greater" = "move workspace to output right";
              "${mod}+less" = "move workspace to output left";

              # Volume control
              "XF86AudioRaiseVolume" = "exec pamixer -ui 5";
              "XF86AudioLowerVolume" = "exec pamixer -ud 5";
              "XF86AudioMute" = "exec pamixer --toggle-mute";

              # Media control
              "XF86AudioPlay" = "exec playerctl play-pause"; # XPS laptop only has play button (?)
              "XF86AudioPause" = "exec playerctl pause";
              "XF86AudioNext" = "exec playerctl next";
              "XF86AudioPrev" = "exec playerctl previous";
            };
            laptopKeys = lib.mkOptionDefault {
              # Screen brightness
              "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
              "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
            };
          in
          lib.mkMerge [
            baseKeys
            (lib.mkIf config.laptop.enable laptopKeys)
          ];

        # Provide title in status bar instead
        window.titlebar = false;

        bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
      };

      # Touchpad swipe to change workspace
      extraConfig = lib.mkIf config.laptop.enable ''
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next
      '';
    };
  };
}
