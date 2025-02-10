{ pkgs, ... }:
{
  home.packages = [ pkgs.dotnetCorePackages.dotnet_9.sdk ];
}
