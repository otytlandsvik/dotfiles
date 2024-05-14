{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.meslo-lgs-nf # Nerdfont
  ];
}
