{ pkgs, ... }:
# Custom shell application to display a powermenu using rofi
# in its dmenu mode
let
  rofi-powermenu = (
    pkgs.writeShellApplication {
      name = "rofi-powermenu";
      runtimeInputs = with pkgs; [ rofi ];
      text = ''
        poweroff=" Power Off"
        reboot=" Reboot"

        menu_output=$(printf "%s\n%s" "$poweroff" "$reboot" | rofi -dmenu -i -p "")

        case "$menu_output" in
          "$poweroff") poweroff ;;
          "$reboot") reboot ;;
          *) exit 1 ;;
        esac
      '';
    }
  );
in
{
  home.packages = [ rofi-powermenu ];
}
