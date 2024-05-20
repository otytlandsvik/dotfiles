{
  pkgs,
  lib,
  config,
  ...
}:
{
  # NOTE: i3status does not allow for left alignment. Switch to waybar?
  imports = [
    ./i3status.nix
    ./mako.nix
  ];

  # Sway related packages
  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    shotman # Screenshot utility
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";

      # Sway overrides xkb config from system
      input = {
        "type:keyboard" = {
          xkb_layout = "us,no";
          xkb_variant = "altgr-intl,";
          xkb_options = "grp:win_space_toggle";
        };
      };

      # Styling overrides
      colors = with config.stylix.base16Scheme; {
        focused = {
          border = lib.mkForce "#${base0D}";
          childBorder = lib.mkForce "#${base0D}";
          indicator = lib.mkForce "#${base0C}";
        };
      };

      # Provide title in status bar instead
      window.titlebar = false;

      keybindings =
        let
          cfg = config.wayland.windowManager.sway.config;
          mod = cfg.modifier;
        in
        # NOTE: mkOptionDefault to extend/override instead of overwriting all keybindings
        lib.mkOptionDefault {
          # Engage swaylock
          "${mod}+Ctrl+l" = "exec swaylock -c 111111";

          # Screenshots
          "Print" = "exec shotman -c region";

          # Open firefox
          "${mod}+x" = "exec firefox";

          # Move workspace to other output
          "${mod}+greater" = "move workspace to output right";
          "${mod}+less" = "move workspace to output left";
        };

      bars = [
        {
          fonts = {
            names = [
              "DejaVu Sans Mono"
              "FontAwesome5Free"
            ];
            style = "Bold Semi-Condensed";
            size = 11.0;
          };
          position = "top";
          # TODO: Find a better way to reference the config
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-statusbar.toml";
        }
      ];
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "7x5";
      indicator-radius = 100;
    };
  };
}
