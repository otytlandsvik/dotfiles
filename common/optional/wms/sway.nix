{
  pkgs,
  lib,
  config,
  ...
}:
{

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
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
    };
  };
}
