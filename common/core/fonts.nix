{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    meslo-lgs-nf # Nerdfont
    font-awesome_5
    dejavu_fonts
  ];
}
