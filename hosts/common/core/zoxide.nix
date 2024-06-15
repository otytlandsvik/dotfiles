{ ... }:
{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd j" ]; # use 'j' instead of default 'z'
  };
}
