{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "eza -l --icons";
      ll = "eza -al --icons";
      ls = "eza";
      lg = "lazygit";
    };

    shellAbbrs = {
      hms = "home-manager switch --flake ~/dotfiles/#ole";
    };
  };
}
