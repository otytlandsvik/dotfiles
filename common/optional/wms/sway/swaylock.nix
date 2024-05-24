{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      effect-blur = "16x12";
      indicator-radius = 100;
      font-size = 14;
    };
  };
}
