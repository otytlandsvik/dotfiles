{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      cursor-style = "block";
      shell-integration-features = "no-cursor";
    };
  };
}
