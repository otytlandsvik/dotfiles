{ pkgs, ... }:
{
  # fonts.fontconfig.enable = true;
  # home.packages = with pkgs; [
  #   meslo-lgs-nf # Nerdfont
  #   font-awesome_5
  #   dejavu_fonts
  # ];

  # Let stylix configure fonts
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  # Also include font awesome
  home.packages = with pkgs; [ font-awesome_5 ];
}
