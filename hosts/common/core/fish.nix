{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "eza -l";
      ll = "eza -al";
      # Truecolor within tmux
      # https://github.com/jesseduffield/lazygit/issues/3668
      lg = "TERM=screen-256color lazygit";
      cat = "bat";
      tree = "eza -T";
      fetch = "fastfetch";
    };

    shellAbbrs = {
      hms = "home-manager switch --flake ~/dotfiles/#ole";
    };

    interactiveShellInit = ''
      set fish_greeting
      set fish_color_param blue
    '';
  };
}
