{ config, ... }:
let
  palette = config.colorScheme.palette;
in
{
  # Notification daemon
  services.mako = {
    enable = true;
    # backgroundColor = "#${palette.base01}";
    # borderColor = "#${palette.base0E}";
    borderSize = 2;
    borderRadius = 2;
    # textColor = "#${palette.base05}";
  };
}
