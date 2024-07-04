{
  pkgs,
  lib,
  config,
  ...
}:
let
  # Use correct packge (--swaylock-effects--)
  swaylockPkg = config.programs.swaylock.package;
  cfg = config.wms.sway.swayidle;
in
{
  options.wms.sway.swayidle = {
    lockTimeout = lib.mkOption {
      type = lib.types.int;
      default = 300;
      description = "idle seconds before swaylock is engaged";
    };
    sleepTimeout = lib.mkOption {
      type = lib.types.int;
      default = 600;
      description = "idle seconds before device is put to sleep";
    };
  };

  config = {
    services.swayidle = {
      enable = true;
      extraArgs = [ "-w" ]; # Wait for commands before sleep
      timeouts = [
        {
          timeout = cfg.lockTimeout;
          command = "${swaylockPkg}/bin/swaylock -f"; # -f to deamonize
        }
        {
          timeout = cfg.sleepTimeout;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
      ];
      events = [
        # Also make sure to engage swaylock on manual suspend
        {
          event = "before-sleep";
          command = "${swaylockPkg}/bin/swaylock -f";
        }
      ];
    };
  };
}
