{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Packages with custom configs
    ./alacritty.nix # Terminal emulator
    ./git.nix
    ./lazygit.nix # Terminal-based git GUI
    ./nixvim # neovim configured through nix
    ./fonts.nix
    ./fish.nix # Shell
    ./starship # Shell prompt
    ./zoxide.nix # cd replacement
    ./eza.nix # ls replacement
    ./btop.nix # fancy htop
    ./bat.nix # cat replacement
    ./direnv.nix
  ];

  # Custom options
  options = {
    laptop.enable = lib.mkEnableOption "Enable laptop-specific features";
  };

  config = {

    laptop.enable = lib.mkDefault false;

    # Let home manager install and manage itself
    programs.home-manager.enable = true;

    # Home manager configuration
    home = {
      username = lib.mkDefault "ole";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
      sessionVariables = {
        SHELL = "fish";
        TERM = "alacritty";
        TERMINAL = "alacritty";
        EDITOR = "nvim";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages without custom configs
    home.packages = builtins.attrValues {
      inherit (pkgs)

        fzf # Fuzzy find
        delta # Diff pager for git
        ripgrep # grep goodness
        fastfetch # System info
        fd # find replacement
        zip
        unzip
        ;
    };
  };
}
