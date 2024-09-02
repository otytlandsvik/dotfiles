{ pkgs, ... }:
# TODO: Add an overlay here
# TODO: Declare the .ideavim config here (write to home)
{
  home.packages = [ pkgs.jetbrains.rider ];
}
