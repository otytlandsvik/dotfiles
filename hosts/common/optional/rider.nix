{ pkgs, ... }:
# TODO: Declare the .ideavim config here (write to home)
{
  home.packages = [ pkgs.jetbrains.rider ];
}
