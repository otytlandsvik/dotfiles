{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      networkmanager_dmenu
      networkmanagerapplet # Needed for advanced connection settings
    ];
    file.".config/networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi -dmenu -i -p
      highlight = True
    '';
  };
}
