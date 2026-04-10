{ pkgs, lib, config, ... }: {
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
      dock.enabled = false;
      # bar = {
      #   widgets = {
      #     right = [
      #       {
      #         id = "Battery";
      #         alwaysShowPercenage = true;
      #       }
      #     ];
      #   };
      # };
    };
    colors = with config.lib.stylix.colors.withHashtag; {
      mPrimary = lib.mkForce base0D;
      mOnPrimary = lib.mkForce base00;
      mSecondary = lib.mkForce base0E;
      mOnSecondary = lib.mkForce base00;
      mTertiary = lib.mkForce base0C;
      mOnTertiary = lib.mkForce base00;
      mError = lib.mkForce base08;
      mOnError = lib.mkForce base00;
      mSurface = lib.mkForce base00;
      mOnSurface = lib.mkForce base05;
      mHover = lib.mkForce base0C;
      mOnHover = lib.mkForce base00;
      mSurfaceVariant = lib.mkForce base01;
      mOnSurfaceVariant = lib.mkForce base04;
      mOutline = lib.mkForce base03;
      mShadow = lib.mkForce base00;
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
