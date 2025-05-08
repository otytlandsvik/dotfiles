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
      k = "kubectl";
    };

    shellAbbrs = {
      # tmux
      t = "tmux";
      ta = "tmux a";
      tn = "tmux new -s";
      # git
      gc = "git commit -v";
      ga = "git add";
      gl = "git log";
    };

    interactiveShellInit = ''
      set fish_greeting
      set fish_color_param blue
    '';
  };
}
