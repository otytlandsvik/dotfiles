{ pkgs, ... }:
# TODO: Add an overlay here
# TODO: Declare the .ideavim config here (write to home)
{
  home.packages = [ pkgs.jetbrains.rider ];

  # Allow old dotnet versions
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
    "dotnet-core-combined"
  ];
}
