{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };
  # Also need Uberzug++ for image preview
  home.packages = [ pkgs.ueberzugpp ];
}
