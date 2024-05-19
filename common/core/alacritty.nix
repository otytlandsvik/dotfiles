{ config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      # Use nix-colors scheme
      colors = with config.colorScheme.palette; {
        bright = {
          black = "0x${base02}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base05}";
          yellow = "0x${base09}";
        };
        cursor = {
          cursor = "0x${base05}";
          text = "0x${base05}";
        };
        normal = {
          black = "0x${base01}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base05}";
          yellow = "0x${base0A}";
        };
        primary = {
          background = "0x${base01}";
          foreground = "0x${base05}";
        };
      };
    };
  };
}
