{
  lib,
  config,
  inputs,
  ...
}:
{

  options.style = {
    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../../../assets/nix-black-4k.png;
      description = "Path to wallpaper image";
    };
    transparency.enable = lib.mkEnableOption "transparency in hyprland";
    hyprlandMonitorConfig = lib.mkOption {
      type = lib.types.str;
      default = ", preferred, auto, 1";
      description = "Monitor config for hyprland";
    };
  };

  config = {

    # Set global color scheme with nix-colors
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

    stylix = {
      enable = true;
      # Pass theme to stylix
      base16Scheme = config.colorScheme.palette;

      image = config.style.wallpaper;
    };
  };
}
