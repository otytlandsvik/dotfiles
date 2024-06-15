{ inputs, ... }:
{
  imports = [
    ################ Required ################
    common/core

    ################ Extras passed from flake ################
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    inputs.stylix.homeManagerModules.stylix

    ################ Optionals ################
    common/optional/wms/sway
    common/optional/cursor.nix
    common/optional/obsidian.nix
    common/optional/discord.nix
    common/optional/ferdium.nix
    common/optional/evince.nix
    common/optional/rider.nix
    common/optional/stylix.nix
  ];

  # Custom options
  laptop.enable = true;
}
