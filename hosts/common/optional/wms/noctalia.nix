{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ gpu-screen-recorder ];
  programs.noctalia-shell = {
    enable = true;
    settings = {
      location = {
        name = "Tromsø";
        firstDayOfWeek = 1;
      };
      ui = {
        panelBackgroundOpacity = lib.mkForce 0.8;
      };
      general = {
        lockScreenBlur = 40;
        lockScreenTint = 18;
        compactLockScreen = true;
        clockStyle = "analog";
      };
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
