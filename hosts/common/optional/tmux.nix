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
      {
        plugin = catppuccin;
        extraConfig = ''
          # Display window name instead of path
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W"
          # Customize status modules
          set -g @catppuccin_date_time_icon ""
          set -g @catppuccin_date_time_text "%H:%M"
          set -g @catppuccin_status_modules_right "session directory date_time"
        '';
      }
    ];
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
