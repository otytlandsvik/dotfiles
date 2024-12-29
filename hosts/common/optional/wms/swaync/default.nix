{ lib, config, ... }:
{
  services.swaync = {
    enable = true;
  };
  xdg.configFile =
    let
      palette = config.stylix.base16Scheme;
      paletteStrings = lib.mapAttrsToList (name: value: "@define-color ${name} #${value};") palette;
    in
    {
      "swaync/config.json".source = lib.mkForce ./config.json;
      "swaync/style.css".source = lib.mkForce ./style.css;
      "swaync/colors.css".text = ''
        ${builtins.concatStringsSep "\n" paletteStrings}
      '';
    };
}
