{ lib, ... }:
{
  imports = [ ./symbols.nix ];

  # Starship, a fast customizable shell prompt written in rust
  programs.starship = {
    enable = true;

    settings = {
      # Left component of prompt
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$line_break"
        "$character"
      ];

      # Right component of prompt
      right_format = lib.concatStrings [
        "$kubernetes"
        "$direnv"
        "nix_shell"
        "$cmd_duration"
        "$os"
      ];

      ######## Customized Starship 'modules' ########
      username = {
        format = "[$user]($style) ";
      };

      hostname = {
        format = "[$ssh_symbol$hostname]($style) ";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only = " 󰌾";
      };

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      cmd_duration = {
        format = "[ $duration]($style) ";
      };

      os = {
        disabled = false;
        format = "on [$symbol]($style)";
        style = "bold blue";
      };
    };
  };
}
