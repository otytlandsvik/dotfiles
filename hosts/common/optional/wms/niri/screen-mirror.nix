{ pkgs, ... }:
# Screenshot with niri and pipe into satty to annotate
let
  niri-mirror = (
    pkgs.writeShellApplication {
      name = "niri-mirror";
      runtimeInputs = with pkgs; [
        wl-mirror
        jq
      ];
      text = ''
        wl-mirror "$(niri msg --json focused-output | jq -r .name)"
      '';
    }
  );
in
{
  home.packages = [ niri-mirror ];
}
