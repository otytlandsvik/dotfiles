{ pkgs, ... }:
# TODO: Add an overlay here
{
  home.packages = [ pkgs.jetbrains.rider ];
}
