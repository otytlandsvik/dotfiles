{ pkgs, ... }:
# Screenshot with niri and pipe into satty to annotate
# From: https://github.com/nickjj/dotfriedrice/blob/master/.local/bin/dfr-screenshot
let
  niri-screenshot = (
    pkgs.writeShellApplication {
      name = "niri-screenshot";
      runtimeInputs = with pkgs; [
        grim
        slurp
        jq
        satty
      ];
      text = ''
        MODE="''${1:-region}"

        case "''${MODE}" in
        region)
          grim -g "$(slurp -d)" -
          ;;
        window)
          niri msg action screenshot-window
          sleep 0.5
          wl-paste --type image/png
          ;;
        monitor)
          grim -o "$(niri msg --json focused-output | jq --raw-output .name)" -
          ;;
        esac | satty --filename - --output-filename "''${XDG_PICTURES_DIR}/screenshot-%+.png"
      '';
    }
  );
in
{
  programs.satty = {
    enable = true;
    settings.general = {
      early-exit = true;
      copy-command = "wl-copy --type image/png";
      initial-tool = "brush";
    };
  };
  home.packages = [ niri-screenshot ];
}
