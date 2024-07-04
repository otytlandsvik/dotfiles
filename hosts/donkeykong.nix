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
    common/optional/evince.nix
    common/optional/ferdium.nix
    common/optional/k9s.nix
    common/optional/kubernetes.nix
    common/optional/obsidian.nix
    common/optional/rider.nix
    common/optional/spotify.nix
    common/optional/stylix.nix
    common/optional/vscode.nix
    common/optional/yazi.nix
  ];

  # Custom options
  laptop.enable = false;
  # Configure widescreen display
  wms.sway.outputConfig = {
    HDMI-A-2 = {
      mode = "3440x1440@49.987Hz";
    };
  };
}
