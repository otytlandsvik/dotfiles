{ pkgs, ... }:
{
  programs.yazi.enable = true;

  # Also need Uberzug++ for image preview
  # TODO: Add ueberzugpp when build error is fixed
  # home.packages = [ pkgs.ueberzugpp ];
}
