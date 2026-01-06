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
      # Zoxide alias for qwerty
      j = "z";
    };

    shellAbbrs = {
      # tmux
      t = "tmux";
      ta = "tmux a";
      tn = "tmux new -s";
      # git
      gc = "git commit -v";
      gca = "git commit --amend --no-edit";
      ga = "git add";
      gl = "git log";
      gpf = "git push --force-with-lease";
      # kubectl
      kcd = "kubectl config set-context --current --namespace";
    };

    functions = {
      kcc = {
        wraps = "kubectl config use";
        body = "kubectl config use $argv";
      };
      kcv = "kubectl config get-contexts";
    };

    interactiveShellInit = ''
      set fish_greeting
      set fish_color_param blue
    '';
  };
}
