{ pkgs, config, ... }:
let
  # Use correct packge (--swaylock-effects--)
  swaylockPkg = config.programs.swaylock.package;
in
{
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ]; # Wait for commands before sleep
    timeouts = [
      {
        timeout = 300;
        command = "${swaylockPkg}/bin/swaylock -f"; # -f to deamonize
      }
      {
        timeout = 600;
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
}
