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
    inputs.noctalia.homeModules.default

    ################ Optionals ################
    common/optional/wms/hyprland
    common/optional/wms/noctalia.nix
    common/optional/claude.nix
    common/optional/chromium.nix
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
    wallpaper = ../assets/diver.jpg;
    transparency.enable = true;
    # hyprlandMonitorConfig = [
    #   "eDP-1, 1920x1200@60.00200, auto, 1,"
    #   "DP-2, 1920x1200@30.000, auto, 1, mirror, eDP-1"
    # ];
  };
}
