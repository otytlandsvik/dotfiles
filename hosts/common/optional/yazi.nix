{ pkgs, ... }:
{
  programs.yazi.enable = true;

  # Also need Uberzug++ for image preview
  home.packages = [ pkgs.ueberzugpp ];
}
