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
    ./mako.nix # notification daemon
    ./swaylock.nix
    ./swayidle.nix
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

      menu = "${pkgs.rofi}/bin/rofi -show drun";

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        # NOTE: mkOptionDefault to extend/override instead of overwriting all keybindings
        lib.mkOptionDefault {
          # Engage swaylock
          "${mod}+Ctrl+l" = "exec swaylock";

          # Screenshots
          "Print" = "exec shotman -c region";

          # Open firefox
          "${mod}+x" = "exec firefox";

          # Open powermenu
          "${mod}+p" = "exec rofi-powermenu";

          # Move workspace to other output
          "${mod}+greater" = "move workspace to output right";
          "${mod}+less" = "move workspace to output left";
        };

      # Provide title in status bar instead
      window.titlebar = false;

      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
    };
  };
}
