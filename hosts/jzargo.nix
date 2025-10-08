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
    common/optional/wms/hyprland
    common/optional/cursor.nix
    common/optional/dia.nix
    common/optional/chromium.nix
    common/optional/discord.nix
    common/optional/dotnet.nix
    common/optional/evince.nix
    common/optional/ferdium.nix
    common/optional/k9s.nix
    common/optional/kubernetes.nix
    common/optional/netcdf.nix
    common/optional/nautilus.nix
    common/optional/obsidian.nix
    common/optional/psql.nix
    common/optional/rclone.nix
    common/optional/rider.nix
    common/optional/spotify.nix
    common/optional/ssh.nix
    common/optional/stylix.nix
    common/optional/tmux.nix
    common/optional/vpn.nix
    common/optional/vscode.nix
    common/optional/yazi.nix
  ];

  # Custom options
  laptop.enable = false;

  # Configure idle timeouts
  wms.hyprland = {
    hypridle = {
      lockTimeout = 900;
      sleepTimeout = 1200;
      suspendTimeout = 1200;
    };
  };

  style = {
    wallpaper = ../assets/old-computer.png;
    transparency.enable = true;
  };

}
