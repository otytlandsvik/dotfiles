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
    common/optional/wms/hyprland
    common/optional/bambu.nix
    common/optional/cursor.nix
    common/optional/discord.nix
    common/optional/evince.nix
    common/optional/ferdium.nix
    common/optional/k9s.nix
    common/optional/kubernetes.nix
    common/optional/obsidian.nix
    common/optional/openfortivpn.nix
    common/optional/rider.nix
    common/optional/spotify.nix
    common/optional/stylix.nix
    common/optional/tmux.nix
    common/optional/vscode.nix
    common/optional/yazi.nix
  ];

  # Custom options
  laptop.enable = true;
}
