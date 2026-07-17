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
        "\${env_var.ZMX_SESSION}"
        "$line_break"
        "$character"
      ];

      # Right component of prompt
      right_format = lib.concatStrings [
        "$kubernetes"
        "$direnv"
        "nix_shell"
        "$cmd_duration"
      ];

      ######## Customized Starship 'modules' ########
      username = {
        format = "[$user]($style) ";
      };

      hostname = {
        format = "[$ssh_symbol$hostname]($style) ";
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

      env_var.ZMX_SESSION = {
        symbol = "󰬇 ";
        format = "[$symbol$env_value]($style) ";
        description = "zmx session name";
        style = "bold blue";
      };

      # os = {
      #   disabled = false;
      #   format = "on [$symbol]($style)";
      #   style = "bold blue";
      # };
    };
  };
}
