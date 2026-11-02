{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [ gpu-screen-recorder ];
  programs.noctalia = {
    enable = true;
    settings = {
      location = {
        address = "Tromsø";
      };
      shell.panel = {
        transparency_mode = lib.mkForce "soft";
      };
      wallpaper = {
        enabled = true;
        default.path = "/home/ole/Pictures/Wallpapers/";
      };
      lockscreen = {
        blur_intensity = 0.40;
        tint_intensity = 0.18;
      };
      dock.enabled = false;
      theme = {
        source = "custom";
        custom_palette = "stylix";
      };
      plugins.enabled = [
        "noctalia/screen_recorder"
        "raycursive/niri-displays"
      ];
    };
    customPalettes = {
      stylix.dark = with config.lib.stylix.colors.withHashtag; {
        mPrimary = base0D;
        mOnPrimary = base00;
        mSecondary = base0E;
        mOnSecondary = base00;
        mTertiary = base0C;
        mOnTertiary = base00;
        mError = base08;
        mOnError = base00;
        mSurface = base00;
        mOnSurface = base05;
        mHover = base0C;
        mOnHover = base00;
        mSurfaceVariant = base01;
        mOnSurfaceVariant = base04;
        mOutline = base03;
        mShadow = base00;
      };
    };
  };
}
