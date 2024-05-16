{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "eza -l";
      ll = "eza -al";
      ls = "eza";
      lg = "lazygit";
      cat = "bat";
      fetch = "fastfetch";
    };

    shellAbbrs = {
      hms = "home-manager switch --flake ~/dotfiles/#ole";
    };
  };
}
