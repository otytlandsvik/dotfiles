{
  lib,
  config,
  ...
}:
{
  options.wms.hypridle = {
    dimTimeout = lib.mkOption {
      type = lib.types.int;
      default = 150;
      description = "Idle seconds before screen is dimmed. Only applies to laptops";
    };
    lockTimeout = lib.mkOption {
      type = lib.types.int;
      default = 300;
      description = "Idle seconds before lock screen is engaged";
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
    lockCommand = lib.mkOption {
      type = lib.types.str;
      default = "noctalia-shell ipc call lockScreen lock";
      description = "Command to engage lock screen";
    };
    dpmsOnCommand = lib.mkOption {
      type = lib.types.str;
      default = "niri msg action power-on-monitors";
      description = "Command to power on displays";
    };
    dpmsOffCommand = lib.mkOption {
      type = lib.types.str;
      default = "niri msg action power-off-monitors";
      description = "Command to power off displays";
    };
  };

  config =
    let
      cfg = config.wms.hypridle;
    in
    {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = cfg.lockCommand;
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = cfg.dpmsOnCommand;
          };

          listener =
            let
              baseTimeouts = [
                {
                  timeout = cfg.lockTimeout;
                  on-timeout = cfg.lockCommand;
                }
                {
                  timeout = cfg.sleepTimeout;
                  on-timeout = cfg.dpmsOffCommand;
                  on-resume = cfg.dpmsOnCommand;
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
                  on-timeout = "${cfg.lockCommand} & systemctl suspend";
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
