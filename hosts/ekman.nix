{ inputs, ... }:
{
  imports = [
    ################ Required ################
    common/core

    ################ Extras passed from flake ################
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    inputs.stylix.homeManagerModules.stylix
    inputs.nix-index-database.homeModules.nix-index

    ################ Optionals ################
    common/optional/dotnet.nix
    common/optional/stylix.nix
    common/optional/netcdf.nix
    common/optional/yazi.nix
  ];

  # Custom config
}
