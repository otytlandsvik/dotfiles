{ inputs, ... }:
{
  imports = [
    ################ Required ################
    common/core

    ################ Extras passed from flake ################
    inputs.nixvim.homeModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    inputs.stylix.homeModules.stylix
    inputs.nix-index-database.homeModules.nix-index

    ################ Optionals ################
    common/optional/wms/hyprland
    common/optional/cursor.nix
    common/optional/dotnet.nix
    common/optional/ferdium.nix
    common/optional/k9s.nix
    common/optional/kubernetes.nix
    common/optional/nautilus.nix
    common/optional/obsidian.nix
    common/optional/papers.nix
    common/optional/rider.nix
    common/optional/spotify.nix
    common/optional/stylix.nix
    common/optional/tmux.nix
    common/optional/vscode.nix
    common/optional/yazi.nix
  ];

  # Custom options
  laptop.enable = true;

  style = {
    wallpaper = ../assets/ersfjord.jpg;
    transparency.enable = true;
  };
}
