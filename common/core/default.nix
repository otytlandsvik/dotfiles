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
  ]; # ++ (builtins.attrValues outputs.homeManagerModules);

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
      bat # cat replacement
      fd # find replacement
      ;
  };
}
