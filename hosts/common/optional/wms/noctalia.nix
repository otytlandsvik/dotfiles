{ pkgs, ... }: {
  home.packages = with pkgs; [ gpu-screen-recorder ];
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      location = {
        name = "Tromsø";
        firstDayOfWeek = 1;
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
