{ config, inputs, ... }:
{

  # Set global color scheme with nix-colors
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  stylix = {
    # Pass theme to stylix
    base16Scheme = config.colorScheme.palette;

    image = ../../../assets/nix-black-4k.png;
  };
}
