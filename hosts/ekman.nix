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
    common/optional/dotnet.nix
    common/optional/stylix.nix
    common/optional/netcdf.nix
    common/optional/yazi.nix
  ];

  # Custom config
}
