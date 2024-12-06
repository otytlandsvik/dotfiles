{ ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    clock24 = true;
    extraConfig = ''
      # Keybinds
      bind | split-window -h
      bind - split-window -v

      # True color
      set -g default-terminal 'tmux-256color'
      set -as terminal-overrides ',alacritty*:Tc'
    '';
  };
}