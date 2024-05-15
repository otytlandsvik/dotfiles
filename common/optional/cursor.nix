{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.simp1e-cursors;
    name = "Simp1e-Catppuccin-Mocha";
    size = 24;
  };
}
