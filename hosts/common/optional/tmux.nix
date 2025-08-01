{ pkgs, ... }:
{
  # Disable stylix to apply theme plugin
  stylix.targets.tmux.enable = false;

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    clock24 = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
    extraConfig = ''
      # Keybinds
      bind | split-window -h
      bind - split-window -v

      # True color
      set -g default-terminal 'tmux-256color'
      # set -as terminal-overrides ',alacritty*:Tc'

      ### Styles ###

      # Panes
      set -g pane-active-border-style 'fg=red'
      set -g pane-border-indicators 'arrows'

      # Command prompt
      set -g message-command-style 'fg=black bg=red'
      set -g message-style 'fg=black bg=red'

      # Status Bar
      set -g status-bg 'black'

      # Window Status
      setw -g window-status-current-style 'fg=black bg=red'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=red bg=black'
      setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

      # Left Status
      set -g status-left ' #[fg=blue][#S] '

      # Right Status
      set -g status-right '#[bg=green fg=black] λ #{=/30/...:pane_title} #[bg=blue fg=black]  %H:%M '
      set -g status-right-length 70
    '';
  };
}
