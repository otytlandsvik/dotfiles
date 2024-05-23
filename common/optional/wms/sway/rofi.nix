{ config, ... }:
let
  # mkLiteral used to escape quotes in target file
  inherit (config.lib.formats.rasi) mkLiteral;
  palette = config.stylix.base16Scheme;
  padding = 12;
  paddingStr = builtins.toString padding;
in
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "run,drun";
      display-drun = "Applications:";
      drun-display-format = "{icon} {name}";
      font = "DejaVu Sans Mono 12";
      show-icons = true;
    };

    theme = {
      window = {
        width = mkLiteral "45%";
        border = 2;
        border-color = mkLiteral "#${palette.base0D}";
      };

      element = {
        inherit padding;
      };

      element-icon = {
        size = 30;
      };

      entry = {
        inherit padding;
      };

      listview = {
        inherit padding;
        lines = 8;
      };

      prompt = {
        padding = mkLiteral "${paddingStr} 0 0 ${paddingStr}";
        text-style = "bold";
      };
    };
  };
}
