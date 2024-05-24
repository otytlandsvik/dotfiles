{ pkgs, config, ... }:
let
  # Use correct packge (swaylock-effects)
  swaylockPkg = config.programs.swaylock.package;
in
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${swaylockPkg}/bin/swaylock";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      # Timeout already engages swaylock, should be sufficient...
      # NOTE: What about after manual suspend?
      # {
      #   event = "before-sleep";
      #   command = "${swaylockPkg}/bin/swaylock";
      # }
      # NOTE: Is this event needed? We already use 'resumeCommand'...
      # {
      #   event = "after-resume";
      #   command = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      # }
    ];
  };
}
