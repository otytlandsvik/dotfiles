{
  lib,
  config,
  ...
}:
{
  options.wms.hyprland.hypridle = {
    dimTimeout = lib.mkOption {
      type = lib.types.int;
      default = 150;
      description = "Idle seconds before screen is dimmed. Only applies to laptops";
    };
    lockTimeout = lib.mkOption {
      type = lib.types.int;
      default = 300;
      description = "Idle seconds before hyprlock is engaged";
    };
    sleepTimeout = lib.mkOption {
      type = lib.types.int;
      default = 600;
      description = "Idle seconds before screen is turned off";
    };
    suspendTimeout = lib.mkOption {
      type = lib.types.int;
      default = 900;
      description = "Idle seconds before device is suspended. Only applies to laptops";
    };
  };

  config =
    let
      lockCommand = "pidof hyprlock || hyprlock";
      cfg = config.wms.hyprland.hypridle;
    in
    {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = lockCommand;
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener =
            let
              baseTimeouts = [
                {
                  timeout = cfg.lockTimeout;
                  on-timeout = lockCommand;
                }
                {
                  timeout = cfg.sleepTimeout;
                  on-timeout = "hyprctl dispatch dpms off";
                  on-resume = "hyprctl dispatch dpms on";
                }
              ];
              laptopTimeouts = [
                {
                  timeout = cfg.dimTimeout;
                  on-timeout = "brightnessctl -s set 40";
                  on-resume = "brightnessctl -r";
                }
                {
                  timeout = cfg.suspendTimeout;
                  on-timeout = "${lockCommand} & systemctl suspend";
                }
              ];
            in
            lib.mkMerge [
              baseTimeouts
              (lib.mkIf config.laptop.enable laptopTimeouts)
            ];
        };
      };
    };
}
